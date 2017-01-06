-- Dumping structure for view spark.v_account
DROP VIEW IF EXISTS `v_account`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_account`;
CREATE ALGORITHM=UNDEFINED VIEW `v_account` AS SELECT
    id,
    name,
    country_alpha2Code,
    city,
    region,
    postalCode,
    taxID,
    phone,
    fax,
    logo,
    modified,
    modifiedBy_id,
    created,
    createdBy_id
  FROM spark.organization ;


-- Dumping structure for view spark.v_catalogitem
DROP VIEW IF EXISTS `v_catalogitem`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_catalogitem`;
CREATE ALGORITHM=UNDEFINED VIEW `v_catalogitem` AS SELECT
    'Product' AS type,
    concat('product-', id) AS identifier,
    name,
    status,
    priceCurrency,
    priceAmount
  FROM spark.product
  UNION ALL
  SELECT
    'Training Credits' AS type,
    concat('training_credit-', id) AS identifier,
    'Training Credit' AS name,
    'ENABLED' as status,
    priceCurrency,
    priceAmount
  FROM spark.trainingcredit
  UNION ALL
  SELECT
    'Instructor Led Training' AS type,
    concat('course-', spark.learningcomponent.id) AS identifier,
    learningcomponent.name,
    learningcomponent.status,
    learningcomponent.priceCurrency,
    learningcomponent.priceAmount
  FROM spark.course
    LEFT JOIN spark.learningcomponent ON spark.learningcomponent.id = course.id
  UNION ALL
  SELECT
    'Exam Component' AS type,
    concat('exam_component-', learningcomponent.id) AS identifier,
    learningcomponent.name,
    learningcomponent.status,
    learningcomponent.priceCurrency,
    learningcomponent.priceAmount
  FROM spark.examcomponent
    LEFT JOIN spark.learningcomponent ON spark.learningcomponent.id = spark.examcomponent.id
  UNION ALL
  SELECT
    'Content Component' AS type,
    concat('content_component-', learningcomponent.id) AS identifier,
    learningcomponent.name,
    learningcomponent.status,
    learningcomponent.priceCurrency,
    learningcomponent.priceAmount
  FROM spark.contentcomponent
    LEFT JOIN spark.learningcomponent ON spark.learningcomponent.id = spark.contentcomponent.id
  UNION ALL
  SELECT
    'eLearning Component' AS type,
    concat('e_learning_component-', learningcomponent.id) AS identifier,
    learningcomponent.name,
    learningcomponent.status,
    learningcomponent.priceCurrency,
    learningcomponent.priceAmount
  FROM spark.elearningcomponent
    LEFT JOIN spark.learningcomponent ON spark.learningcomponent.id = spark.elearningcomponent.id
  UNION ALL
  SELECT
    'Course' AS type,
    concat('course_pathway-', spark.learningcomponent.id) AS identifier,
    learningcomponent.name,
    learningcomponent.status,
    learningcomponent.priceCurrency,
    learningcomponent.priceAmount
  FROM spark.coursepathway
    LEFT JOIN spark.learningcomponent ON spark.learningcomponent.id = spark.coursepathway.id
  UNION ALL
  SELECT
    'Learning Pathway' AS type,
    concat('learning_pathway-', spark.learningcomponent.id) AS identifier,
    learningcomponent.name,
    learningcomponent.status,
    learningcomponent.priceCurrency,
    learningcomponent.priceAmount
  FROM spark.learningpathway
    LEFT JOIN spark.learningcomponent ON spark.learningcomponent.id = spark.learningpathway.id ;


-- Dumping structure for view spark.v_category
DROP VIEW IF EXISTS `v_category`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_category`;
CREATE ALGORITHM=UNDEFINED VIEW `v_category` AS SELECT
   concat('knowledge_category-', id) AS identifier,
   name
  FROM spark.knowledgecategory
  UNION ALL
  SELECT
   concat('product_category-', id) AS identifier,
   name
  FROM spark.productcategory ;


-- Dumping structure for view spark.v_class
DROP VIEW IF EXISTS `v_class`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_class`;
CREATE ALGORITHM=UNDEFINED VIEW `v_class` AS SELECT
    capacity,
    course_id,
    courseevent.id,
    event.location_id,
    (event.durationInMinutes * event.repeatDayCount) / 60 AS totalHours,
    learningcomponent.provider_id,
    'Public Class' AS type,
    courseevent.language,
    equipmentProvided,
    refreshmentsProvided,
    foodProvided,
    snacksProvided,
    coursewareProvided,
    event.startTime,
    event.status
  FROM spark.courseevent
    JOIN spark.publiccourseevent ON spark.publiccourseevent.id = spark.courseevent.id
    LEFT JOIN spark.event ON spark.event.id = spark.courseevent.id
    LEFT JOIN spark.learningcomponent ON spark.learningcomponent.id = spark.courseevent.course_id
  UNION
  SELECT
    capacity,
    course_id,
    courseevent.id,
    event.location_id,
    (event.durationInMinutes * event.repeatDayCount) / 60 AS totalHours,
    learningcomponent.provider_id,
    'Private Engagement' AS type,
    courseevent.language,
    equipmentProvided,
    refreshmentsProvided,
    foodProvided,
    snacksProvided,
    coursewareProvided,
    event.startTime,
    event.status
  FROM spark.courseevent
    JOIN spark.privatecourseevent ON spark.privatecourseevent.id = spark.courseevent.id
    LEFT JOIN spark.event ON spark.event.id = spark.courseevent.id
    LEFT JOIN spark.learningcomponent ON spark.learningcomponent.id = spark.courseevent.course_id ;


-- Dumping structure for view spark.v_classinstructor
DROP VIEW IF EXISTS `v_classinstructor`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_classinstructor`;
CREATE ALGORITHM=UNDEFINED VIEW `v_classinstructor` AS SELECT
    courseevent_id,
    contact_id,
    CONCAT(courseevent_id, ':', contact_id) as identifier
  FROM spark.courseevent_instructor ;


-- Dumping structure for view spark.v_contact
DROP VIEW IF EXISTS `v_contact`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_contact`;
CREATE ALGORITHM=UNDEFINED VIEW `v_contact` AS SELECT
    contact.id,
    email,
    firstName,
    lastName,
    street1,
    street2,
    city,
    region,
    postalcode,
    country_alpha2code,
    if(birthDate > "1900-01-01", birthDate, NULL) AS birthDate,
    title,
    department,
    label.label as salutation,
    officephone,
    mobilephone,
    homephone,
    fax,
    emailverified,
    contact.enabled,
    staffEnabled,
    taxID,
    lastPasswordReset,
    lastSuccessfulLogin,
    concat(firstName, ' ', lastName) AS name,
    numberOfSuccessfulLogins,
    numberOfForumPosts,
    contact.created,
    organization_id
  FROM spark.contact
    LEFT JOIN spark.label ON spark.label.id = spark.contact.salutation_id ;


-- Dumping structure for view spark.v_course
DROP VIEW IF EXISTS `v_course`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_course`;
CREATE ALGORITHM=UNDEFINED VIEW `v_course` AS SELECT
    learningcomponent.id,
    learningcomponent.name,
    coursepathwaytype.name AS type
  FROM spark.learningcomponent
    LEFT JOIN spark.coursepathway ON spark.coursepathway.id = spark.learningcomponent.id
    LEFT JOIN spark.coursepathwaytype ON spark.coursepathwaytype.id = spark.coursepathway.type_id
  WHERE keyword = 'course_pathway' ;


-- Dumping structure for view spark.v_courseprogress
DROP VIEW IF EXISTS `v_courseprogress`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_courseprogress`;
CREATE ALGORITHM=UNDEFINED VIEW `v_courseprogress` AS SELECT
    enrolment.contact_id,
    courserequirement.pathway_id,
    count(DISTINCT (enrolment.component_id)) / (SELECT count(a.component_id)
                                                FROM spark.courserequirement AS a
                                                WHERE a.pathway_id = spark.courserequirement.pathway_id) AS progress,
    max(enrolment.created) AS created,
    contact.organization_id
  FROM spark.enrolment
    JOIN spark.courserequirement ON courserequirement.component_id = enrolment.component_id
    LEFT JOIN spark.contact ON spark.contact.id = spark.enrolment.contact_id
  WHERE status = 'PASSED' AND pathway_id IS NOT NULL
  GROUP BY spark.courserequirement.pathway_id, spark.enrolment.contact_id ;


-- Dumping structure for view spark.v_discount
DROP VIEW IF EXISTS `v_discount`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_discount`;
CREATE ALGORITHM=UNDEFINED VIEW `v_discount` AS SELECT
    amount,
    discountuse.rule_id,
    orderdiscount.id,
    item_id,
    orderdiscount.created
  FROM spark.orderdiscount
    LEFT OUTER JOIN spark.discountuse ON spark.discountuse.id = spark.orderdiscount.discountUse_id ;


-- Dumping structure for view spark.v_discountrule
DROP VIEW IF EXISTS `v_discountrule`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_discountrule`;
CREATE ALGORITHM=UNDEFINED VIEW `v_discountrule` AS SELECT
    id,
    code,
    enabled
  FROM spark.discountrule ;


-- Dumping structure for view spark.v_enrollment
DROP VIEW IF EXISTS `v_enrollment`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_enrollment`;
CREATE ALGORITHM=UNDEFINED VIEW `v_enrollment` AS SELECT
    enrolment.status,
    completionDate,
    expiryDate,
    elearningsession.score,
    elearningsession.totalSecondsTracked,
    confidence,
    enrolment.id,
    component_id,
    contact_id,
    coursesession.event_id,
    enrolment.created,
    enrolment.modified,
    IFNULL(courseevent.provider_id, learningcomponent.provider_id) AS provider_id
  FROM spark.enrolment
    LEFT JOIN spark.learningsession ON spark.learningsession.enrolment_id = spark.enrolment.id
    LEFT JOIN spark.coursesession ON spark.coursesession.id = spark.learningsession.id
    LEFT JOIN spark.elearningsession ON spark.elearningsession.id = spark.learningsession.id
    LEFT JOIN spark.courseevent ON spark.courseevent.id = spark.coursesession.event_id
    LEFT JOIN spark.learningcomponent ON spark.learningcomponent.id = spark.enrolment.component_id ;


-- Dumping structure for view spark.v_instructor
DROP VIEW IF EXISTS `v_instructor`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_instructor`;
CREATE ALGORITHM=UNDEFINED VIEW `v_instructor` AS SELECT
    contact_id,
    CONCAT(spark.contact.firstName, ' ', spark.contact.lastName) AS name
  FROM spark.courseevent_instructor
    LEFT JOIN spark.contact ON spark.contact.id = spark.courseevent_instructor.contact_id ;


-- Dumping structure for view spark.v_lead
DROP VIEW IF EXISTS `v_lead`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_lead`;
CREATE ALGORITHM=UNDEFINED VIEW `v_lead` AS SELECT
    requestforcontact.id,
    status,
    requestforcontact.created,
    contact_id,
    label.label AS subject,
    count(*) quantity
  FROM spark.requestforcontact
    LEFT JOIN spark.label ON spark.label.id = spark.requestforcontact.subject_id
  GROUP BY spark.requestforcontact.id,
    status,
    requestforcontact.created,
    contact_id,
    label.label ;


-- Dumping structure for view spark.v_learningcomponent
DROP VIEW IF EXISTS `v_learningcomponent`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_learningcomponent`;
CREATE ALGORITHM=UNDEFINED VIEW `v_learningcomponent` AS SELECT
    id,
    name,
    language,
    CASE keyword
      WHEN 'course' THEN 'Instructor Led Training'
      WHEN 'quiz_component' THEN 'Quiz Component'
      WHEN 'exam_component' THEN 'Exam'
      WHEN 'content_component' THEN 'Content Component'
      WHEN 'e_learning_component' THEN 'eLearning Component'
      WHEN 'course_pathway' THEN 'Course'
      WHEN 'learning_pathway' THEN 'Learning Pathway'
      ELSE keyword
    END as type
  FROM spark.learningcomponent ;


-- Dumping structure for view spark.v_learningpathwayprogress
DROP VIEW IF EXISTS `v_learningpathwayprogress`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_learningpathwayprogress`;
CREATE ALGORITHM=UNDEFINED VIEW `v_learningpathwayprogress` AS SELECT
    enrolment.contact_id,
    learningpathwayrequirement.learningpathway_id,
    count(DISTINCT (enrolment.component_id)) / (SELECT count(a.learningUnit_id)
                                                FROM spark.learningpathwayrequirement AS a
                                                WHERE a.learningpathway_id =
                                                      spark.learningpathwayrequirement.learningPathway_id) AS progress,
    max(enrolment.created) AS created,
    contact.organization_id
  FROM spark.enrolment
    JOIN spark.learningpathwayrequirement ON spark.learningpathwayrequirement.learningUnit_id = spark.enrolment.component_id
    LEFT JOIN spark.contact ON spark.contact.id = spark.enrolment.contact_id
  WHERE status = 'PASSED' AND learningpathway_id IS NOT NULL
  GROUP BY spark.learningpathwayrequirement.learningpathway_id, spark.enrolment.contact_id ;


-- Dumping structure for view spark.v_location
DROP VIEW IF EXISTS `v_location`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_location`;
CREATE ALGORITHM=UNDEFINED VIEW `v_location` AS SELECT
    id,
    city,
    region,
    country_alpha2Code,
    postalcode,
    name,
    timezone,
    online
  FROM spark.location ;


-- Dumping structure for view spark.v_opportunity
DROP VIEW IF EXISTS `v_opportunity`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_opportunity`;
CREATE ALGORITHM=UNDEFINED VIEW `v_opportunity` AS SELECT
    opportunity.id,
    valueCurrency,
    stage,
    requestForContact_id,
    customer_id,
    customerOrganization_id,
    created,
    stageLastModified,
    valueAmount,
    CASE type
      WHEN 'ONSITE' THEN 'Quote'
      WHEN 'PUBLIC' THEN 'Class Request'
      ELSE type
    END as type
  FROM spark.opportunity
    LEFT JOIN spark.trainingopportunity ON spark.opportunity.id = spark.trainingopportunity.id ;


-- Dumping structure for view spark.v_order
DROP VIEW IF EXISTS `v_order`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_order`;
CREATE ALGORITHM=UNDEFINED VIEW `v_order` AS SELECT
    orders.id,
    orders.status,
    customer_id as contact_id,
    contact.organization_id as account_id,
    orders.payment_id,
    orders.created,
    orders.createdBy_id,
    orders.modified,
    orders.modifiedBy_id,
    SUM(v_orderitem.total) as total
  FROM spark.orders
  LEFT JOIN spark.contact ON spark.orders.customer_id = spark.contact.id
  INNER JOIN spark.v_orderitem ON spark.orders.id = spark.v_orderitem.order_id
  GROUP BY
    orders.id,
   orders.status,
  customer_id,
    contact.organization_id,
    payment_id,
   orders.created,
    orders.createdBy_id,
    orders.modified,
    orders.modifiedBy_id ;


-- Dumping structure for view spark.v_orderdiscount
DROP VIEW IF EXISTS `v_orderdiscount`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_orderdiscount`;
CREATE ALGORITHM=UNDEFINED VIEW `v_orderdiscount` AS SELECT
    id,
    currency
  FROM spark.orderdiscount ;


-- Dumping structure for view spark.v_orderitem
DROP VIEW IF EXISTS `v_orderitem`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_orderitem`;
CREATE ALGORITHM=UNDEFINED VIEW `v_orderitem` AS SELECT
    orderitem.status,
    IF(payment.status = 'PROCESSED', TRUE, FALSE) AS paid,
    orderitem.priceAmount,
    IFNULL((SELECT sum(amount)
            FROM spark.orderdiscount
            WHERE  item_id = orderitem.id), 0) AS discount,
    taxAmount,
    (orderitem.priceAmount + taxAmount - IFNULL((SELECT sum(amount)
                                                 FROM spark.orderdiscount
                                                 WHERE item_id = orderitem.id),
                                                0)) AS total,
    IFNULL(trainingCredits, 0) AS trainingCredits,
    orderitem.id,
    concat(targetType, '-', targetId) AS target,
    contact.id                                      AS contactId,
    contact.organization_id,
    concat('product_category-', product.category_id) AS category,
    orders.payment_id,
    order_id,
    orderitem.created,
    product.provider_id,
    NULL AS targetId
  FROM spark.orderitem
    LEFT JOIN spark.orders ON spark.orders.id = spark.orderitem.order_id
    LEFT JOIN spark.payment ON spark.payment.id = spark.orders.payment_id
    LEFT JOIN spark.contact ON spark.contact.id = spark.orders.customer_id
    LEFT JOIN spark.product ON spark.product.id = spark.orderitem.targetId
  WHERE orderitem.targetType = 'product'
  UNION ALL
  SELECT
    orderitem.status,
    IF(payment.status = 'PROCESSED', TRUE, FALSE) AS paid,
    orderitem.priceAmount,
    IFNULL((SELECT sum(amount)
            FROM spark.orderdiscount
            WHERE item_id = orderitem.id), 0) AS discount,
    taxAmount,
    (orderitem.priceAmount + taxAmount - IFNULL((SELECT sum(amount)
                                                 FROM spark.orderdiscount
                                                 WHERE item_id = orderitem.id),
                                                0)) AS total,
    IFNULL(trainingCredits, 0) AS trainingCredits,
    orderitem.id,
    concat(targetType, '-', targetId) AS target,
    contact.id                                      AS contactId,
    contact.organization_id,
    NULL as category,
    orders.payment_id,
    order_id,
    orderitem.created,
    NULL AS provider_id,
    NULL AS targetId
  FROM spark.orderitem
    LEFT JOIN spark.orders ON orders.id = orderitem.order_id
    LEFT JOIN spark.payment ON payment.id = orders.payment_id
    LEFT JOIN spark.contact ON contact.id = orders.customer_id
    LEFT JOIN spark.trainingcredit ON trainingcredit.id = orderitem.targetId
  WHERE orderitem.targetType = 'training_credit'
  UNION ALL
  SELECT
    orderitem.status,
    IF(payment.status = 'PROCESSED', TRUE, FALSE) AS paid,
    orderitem.priceAmount,
    IFNULL((SELECT sum(amount)
            FROM spark.orderdiscount
            WHERE item_id = orderitem.id), 0) AS discount,
    taxAmount,
    (orderitem.priceAmount + taxAmount - IFNULL((SELECT sum(amount)
                                                 FROM spark.orderdiscount
                                                 WHERE item_id = orderitem.id),
                                                0)) AS total,
    IFNULL(trainingCredits, 0) AS trainingCredits,
    orderitem.id,
    concat(targetType, '-', targetId) AS target,
    contact.id                                      AS contactId,
    contact.organization_id,
    concat('knowledge_category-', learningcomponent.primaryCategory_id) as category,
    orders.payment_id,
    order_id,
    orderitem.created,
    learningcomponent.provider_id,
    NULL AS targetId
  FROM spark.orderitem
    LEFT JOIN spark.orders ON orders.id = orderitem.order_id
    LEFT JOIN spark.payment ON payment.id = orders.payment_id
    LEFT JOIN spark.contact ON contact.id = orders.customer_id
    LEFT JOIN spark.learningcomponent ON learningcomponent.id = orderitem.targetId
  WHERE orderitem.targetType IN
        ('exam_component', 'content_component', 'e_learning_component', 'course', 'course_pathway', 'learning_pathway')
  UNION ALL
  SELECT
    orderitem.status,
    IF(payment.status = 'PROCESSED', TRUE, FALSE) AS paid,
    orderitem.priceAmount,
    IFNULL((SELECT sum(amount)
            FROM spark.orderdiscount
            WHERE item_id = orderitem.id), 0) AS discount,
    taxAmount,
    (orderitem.priceAmount + taxAmount - IFNULL((SELECT sum(amount)
                                                 FROM spark.orderdiscount
                                                 WHERE item_id = orderitem.id),
                                                0)) AS total,
    IFNULL(trainingCredits, 0) AS trainingCredits,
    orderitem.id,
    concat('content_component-', learningcomponent.id) AS target,
    contact.id                                      AS contactId,
    contact.organization_id,
    concat('knowledge_category-', learningcomponent.primaryCategory_id) as category,
    orders.payment_id,
    order_id,
    orderitem.created,
    learningcomponent.provider_id,
    NULL AS targetId
  FROM spark.orderitem
    LEFT JOIN spark.orders ON orders.id = orderitem.order_id
    LEFT JOIN spark.payment ON payment.id = orders.payment_id
    LEFT JOIN spark.contact ON contact.id = orders.customer_id
    LEFT JOIN spark.contentoption ON contentoption.id = orderitem.targetId
    LEFT JOIN spark.learningcomponent ON learningcomponent.id = contentoption.component_id
  WHERE orderitem.targetType = 'content_option'
  UNION ALL
  SELECT
    orderitem.status,
    IF(payment.status = 'PROCESSED', TRUE, FALSE) AS paid,
    orderitem.priceAmount,
    IFNULL((SELECT sum(amount)
            FROM spark.orderdiscount
            WHERE item_id = orderitem.id), 0) AS discount,
    taxAmount,
    (orderitem.priceAmount + taxAmount - IFNULL((SELECT sum(amount)
                                                 FROM spark.orderdiscount
                                                 WHERE item_id = orderitem.id),
                                                0)) AS total,
    IFNULL(trainingCredits, 0) AS trainingCredits,
    orderitem.id,
    concat('course-', learningcomponent.id) AS target,
    contact.id                                      AS contactId,
    contact.organization_id,
    concat('knowledge_category-', learningcomponent.primaryCategory_id) as category,
    orders.payment_id,
    order_id,
    orderitem.created,
    learningcomponent.provider_id,
    orderitem.targetid
  FROM spark.orderitem
    LEFT JOIN spark.orders ON orders.id = orderitem.order_id
    LEFT JOIN spark.payment ON payment.id = orders.payment_id
    LEFT JOIN spark.contact ON contact.id = orders.customer_id
    LEFT JOIN spark.courseevent ON courseevent.id = orderitem.targetId
    LEFT JOIN spark.learningcomponent ON learningcomponent.id = courseevent.course_id
  WHERE orderitem.targetType IN ('private_course_event', 'public_course_event') ;


-- Dumping structure for view spark.v_orderitem_options
DROP VIEW IF EXISTS `v_orderitem_options`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_orderitem_options`;
CREATE ALGORITHM=UNDEFINED VIEW `v_orderitem_options` AS SELECT OrderItem_id, element, mapkey
  from spark.orderitem_options ;


-- Dumping structure for view spark.v_pathway
DROP VIEW IF EXISTS `v_pathway`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_pathway`;
CREATE ALGORITHM=UNDEFINED VIEW `v_pathway` AS SELECT
    learningpathway.id,
    name
  FROM spark.learningcomponent
    JOIN spark.learningpathway ON learningpathway.id = learningcomponent.id ;


-- Dumping structure for view spark.v_payment
DROP VIEW IF EXISTS `v_payment`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_payment`;
CREATE ALGORITHM=UNDEFINED VIEW `v_payment` AS SELECT
    payment.id,
    firstName,
    lastName,
    organization,
    taxID,
    taxcountry_alpha2Code,
    phone,
    email,
    currency,
    failureMessage,
    payment.status,
    street1,
    street2,
    city,
    region,
    postalCode,
    country_alpha2code,
    creditcardpayment.processingDate AS date,
    creditcardpayment.processingConfirmation AS number,
    'Credit Card' as type,
    payment.amount,
    orders.id AS order_id,
    payment.created
  FROM spark.creditcardpayment
    LEFT JOIN spark.payment ON creditcardpayment.id = payment.id
    LEFT JOIN spark.orders ON orders.payment_id = payment.id
  UNION ALL
  SELECT
    payment.id,
    firstName,
    lastName,
    organization,
    taxID,
    taxcountry_alpha2Code,
    phone,
    email,
    currency,
    failureMessage,
    payment.status,
    street1,
    street2,
    city,
    region,
    postalCode,
    country_alpha2code,
    NULL AS date,
    purchaseorderpayment.purchaseOrderNumber AS number,
    'Purchase Order' as type,
    payment.amount,
    orders.id AS order_id,
    payment.created
  FROM spark.purchaseorderpayment
    LEFT JOIN spark.payment ON purchaseorderpayment.id = payment.id
    LEFT JOIN spark.orders ON orders.payment_id = payment.id
  UNION ALL
  SELECT
    payment.id,
    firstName,
    lastName,
    organization,
    taxID,
    taxcountry_alpha2Code,
    phone,
    email,
    currency,
    failureMessage,
    payment.status,
    street1,
    street2,
    city,
    region,
    postalCode,
    country_alpha2code,
    trainingcredittransaction.created AS date,
    trainingcredittransaction.id AS number,
    'Training Credit' as type,
    payment.amount,
    orders.id AS order_id,
    payment.created
  FROM spark.trainingcreditpayment
    LEFT JOIN spark.payment ON trainingcreditpayment.id = payment.id
    LEFT JOIN spark.trainingcredittransaction
      ON trainingcredittransaction.id = trainingcreditpayment.transaction_id
    LEFT JOIN spark.orders ON orders.payment_id = payment.id ;


-- Dumping structure for view spark.v_provider
DROP VIEW IF EXISTS `v_provider`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_provider`;
CREATE ALGORITHM=UNDEFINED VIEW `v_provider` AS SELECT
    id,
    name
  FROM spark.provider ;


-- Dumping structure for view spark.v_streampost
DROP VIEW IF EXISTS `v_streampost`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_streampost`;
CREATE ALGORITHM=UNDEFINED VIEW `v_streampost` AS SELECT
    streampost.id,
    streampost.urlName,
    streampost.title,
    streampost.created,
    streampost.author_id,
    streampost.numberofviews,
    (SELECT count(id)
     FROM spark.streampostcomment
     WHERE streampostcomment.post_id = streampost.id) AS comments
  FROM spark.streampost ;


-- Dumping structure for view spark.v_streampostcategory
DROP VIEW IF EXISTS `v_streampostcategory`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_streampostcategory`;
CREATE ALGORITHM=UNDEFINED VIEW `v_streampostcategory` AS SELECT
    concat('knowledge_category-', category_id, ':', streampost_id) AS identifier,
    streampost_id,
    concat('knowledge_category-', category_id) AS category_identifier
  FROM spark.streampost_categories ;


-- Dumping structure for view spark.v_trainingcreditaccount
DROP VIEW IF EXISTS `v_trainingcreditaccount`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_trainingcreditaccount`;
CREATE ALGORITHM=UNDEFINED VIEW `v_trainingcreditaccount` AS SELECT
    id,
    name,
    created,
    IFNULL((SELECT balance
            FROM spark.trainingcredittransaction
            WHERE trainingcredittransaction.account_id = trainingcreditaccount.id
            ORDER BY created DESC
            LIMIT 1), 0) AS balance
  FROM spark.trainingcreditaccount ;


-- Dumping structure for view spark.v_trainingcreditexpiry
DROP VIEW IF EXISTS `v_trainingcreditexpiry`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_trainingcreditexpiry`;
CREATE ALGORITHM=UNDEFINED VIEW `v_trainingcreditexpiry` AS SELECT
    account_id,
    trainingcreditcredittransaction.expiry,
    (amount - IFNULL((SELECT sum(amount)
                      FROM spark.trainingcreditusage
                      WHERE creditTransaction_id = trainingcreditcredittransaction.id), 0)) AS amount
  FROM spark.trainingcredittransaction
    LEFT JOIN spark.trainingcreditcredittransaction ON trainingcreditcredittransaction.id = trainingcredittransaction.id
  WHERE reconciled = FALSE AND amount > 0 AND expiry IS NOT NULL ;


-- Dumping structure for view spark.v_trainingcreditredemptionrequest
DROP VIEW IF EXISTS `v_trainingcreditredemptionrequest`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_trainingcreditredemptionrequest`;
CREATE ALGORITHM=UNDEFINED VIEW `v_trainingcreditredemptionrequest` AS SELECT
    amount,
    trainingcreditredemptionrequest.id,
    trainingcreditredemptionrequest.status,
    account_id,
    orders.id AS order_id,
    requester_id,
    trainingcreditredemptionrequest.payment_id,
    trainingcreditredemptionrequest.created,
    expiry
  FROM spark.trainingcreditredemptionrequest
    LEFT JOIN spark.orders ON orders.payment_id = trainingcreditredemptionrequest.payment_id ;


-- Dumping structure for view spark.v_trainingcredittransaction
DROP VIEW IF EXISTS `v_trainingcredittransaction`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_trainingcredittransaction`;
CREATE ALGORITHM=UNDEFINED VIEW `v_trainingcredittransaction` AS SELECT
    amount,
    reconciled,
    account_id,
    created
  FROM spark.trainingcredittransaction ;


-- Dumping structure for view spark.v_trainingsurveyresponse
DROP VIEW IF EXISTS `v_trainingsurveyresponse`;
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `v_trainingsurveyresponse`;
CREATE ALGORITHM=UNDEFINED VIEW `v_trainingsurveyresponse` AS SELECT
    trainingsurveyresponse.timestamp,
    trainingsurveyresponse.comeAgainRating,
    trainingsurveyresponse.facilitiesAmenitiesRating,
    trainingsurveyresponse.facilitiesEquipmentRating,
    trainingsurveyresponse.facilitiesLocationRating,
    trainingsurveyresponse.instructorKnowledgeRating,
    trainingsurveyresponse.instructorPaceRating,
    trainingsurveyresponse.instructorPresentationRating,
    trainingsurveyresponse.instructorQuestionsRating,
    trainingsurveyresponse.instructorSkillsRating,
    trainingsurveyresponse.overallRating,
    trainingsurveyresponse.recommendRating,
    trainingsurveyresponse.trainingCurriculumRating,
    trainingsurveyresponse.trainingExpectationsRating,
    trainingsurveyresponse.trainingLabsRating,
    trainingsurveyresponse.trainingObjectivesRating,
    trainingsurveyresponse.trainingOrganizedRating,
    trainingsurveyresponse.trainingOverallRating,
    trainingsurveyresponse.courseEvent_id,
    trainingsurveyresponse.participant_id,
    event.location_id,
    courseevent.course_id
  FROM spark.trainingsurveyresponse
    LEFT JOIN spark.courseevent ON courseevent.id = trainingsurveyresponse.courseEvent_Id
    LEFT JOIN spark.event ON event.id = courseevent.id ;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
