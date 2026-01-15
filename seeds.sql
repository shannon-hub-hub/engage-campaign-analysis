CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_gender VARCHAR(10),
    user_age INT,
    age_group VARCHAR(20),
    country VARCHAR(50),
    location VARCHAR(100),
    interests VARCHAR(255)
) 

CREATE TABLE campaigns (
    campaign_id INT PRIMARY KEY,
    c_name VARCHAR(50),
    c_start_date DATE,
    c_end_date DATE,
    duration_days INT,
    total_budget DECIMAL(10, 2)
);

CREATE TABLE ads_new (
    ad_id INT PRIMARY KEY,
    campaign_id INT,
    ad_platform VARCHAR(20),
    ad_type VARCHAR(20),
    target_gender VARCHAR(10),
    target_age_group VARCHAR(20), 
    target_interests VARCHAR(100),
    FOREIGN KEY (campaign_id) REFERENCES campaigns(campaign_id)
);


CREATE TABLE events (
    event_id INT PRIMARY KEY,
    ad_id INT,
    user_id INT,
    evt_timestamp TIMESTAMP,
    day_of_week VARCHAR(10),
    time_of_day VARCHAR(10),
    event_type VARCHAR(20),
    FOREIGN KEY (ad_id) REFERENCES ads_new(ad_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

LOAD DATA LOCAL INFILE '/Users/shannonchiang/projects/engage/data/users.csv'
INTO TABLE events
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(user_id, user_gender, user_age, age_group, country, location, interests);

LOAD DATA LOCAL INFILE '/Users/shannonchiang/projects/engage/data/campaigns.csv'
INTO TABLE events
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(campaign_id, c_name, c_start_date, c_end_date, duration_days, total_budget);

LOAD DATA LOCAL INFILE '/Users/shannonchiang/projects/engage/data/ads.csv'
INTO TABLE events
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ad_id, campaign_id, ad_platform, ad_type, target_gender, target_age_group, target_interests);

LOAD DATA LOCAL INFILE '/Users/shannonchiang/projects/engage/data/ad_events.csv'
INTO TABLE events
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(event_id, ad_id, user_id, evt_timestamp, day_of_week, time_of_day, event_type);

