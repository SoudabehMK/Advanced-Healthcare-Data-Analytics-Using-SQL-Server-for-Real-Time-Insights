--Create Database
CREATE DATABASE HealthcaredataDb;
GO

-- Create Tables
USE HealthcaredataDb;
GO

CREATE TABLE [dbo].[Customers] (
    user_id VARCHAR(10) PRIMARY KEY,
    age INT NOT NULL CHECK (age BETWEEN 0 AND 120),  
    gender CHAR(1) NOT NULL CHECK (gender IN ('M', 'F')), 
    city VARCHAR(100) NOT NULL,
    state VARCHAR(50),
    country VARCHAR(50) NOT NULL,
    occupation VARCHAR(100),
    income_bracket VARCHAR(20),
    registration_date DATE NOT NULL DEFAULT GETDATE(), 
    subscription_type VARCHAR(50) NOT NULL CHECK (subscription_type IN ('Basic', 'Premium', 'Enterprise')) 
);
GO


CREATE TABLE [dbo].[Sales] (
    sale_id VARCHAR(10) PRIMARY KEY,
    user_id VARCHAR(10) NOT NULL,
    sale_date DATE NOT NULL DEFAULT GETDATE(),
    product_id VARCHAR(20) NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    product_category VARCHAR(50) NOT NULL CHECK (product_category IN ('Device', 'Accessory', 'Subscription')),
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0),
    quantity INT NOT NULL CHECK (quantity > 0),
    discount_applied DECIMAL(5,2) CHECK (discount_applied BETWEEN 0 AND 100),
    total_amount DECIMAL(10,2) NOT NULL CHECK (total_amount >= 0),
    payment_method VARCHAR(50) NOT NULL CHECK (payment_method IN ('Credit Card', 'PayPal', 'Bank Transfer')),
    subscription_plan VARCHAR(50),
    sales_channel VARCHAR(50) NOT NULL CHECK (sales_channel IN ('Online', 'Retail','Direct Sales')),
    region VARCHAR(50) NOT NULL,
    sales_rep_id VARCHAR(10) NOT NULL
);
GO


CREATE TABLE [dbo].[HealthMetrics] (
    record_id VARCHAR(10) PRIMARY KEY,
    user_id VARCHAR(10) NOT NULL,
    month_date DATE NOT NULL,
    avg_heart_rate INT NOT NULL CHECK (avg_heart_rate BETWEEN 30 AND 200),
    avg_resting_heart_rate INT NOT NULL CHECK (avg_resting_heart_rate BETWEEN 30 AND 100),
    avg_daily_steps INT NOT NULL CHECK (avg_daily_steps >= 0),
    avg_sleep_hours DECIMAL(3,1) NOT NULL CHECK (avg_sleep_hours BETWEEN 0 AND 24),
    avg_deep_sleep_hours DECIMAL(3,1) NOT NULL CHECK (avg_deep_sleep_hours BETWEEN 0 AND 12),
    avg_daily_calories INT NOT NULL CHECK (avg_daily_calories >= 0),
    avg_exercise_minutes INT NOT NULL CHECK (avg_exercise_minutes >= 0),
    avg_stress_level DECIMAL(3,1) CHECK (avg_stress_level BETWEEN 0 AND 10),
    avg_blood_oxygen DECIMAL(4,1) NOT NULL CHECK (avg_blood_oxygen BETWEEN 80 AND 100),
    total_active_days INT NOT NULL CHECK (total_active_days BETWEEN 0 AND 31),
    workout_frequency INT NOT NULL CHECK (workout_frequency BETWEEN 0 AND 7),
    achievement_rate DECIMAL(3,2) CHECK (achievement_rate BETWEEN 0 AND 1)
);
GO


CREATE TABLE [dbo].[Devices] (
    device_id VARCHAR(10) PRIMARY KEY,
    user_id VARCHAR(10) NOT NULL,
    device_type VARCHAR(100) NOT NULL,
    purchase_date DATE NOT NULL DEFAULT GETDATE(),
    last_sync_date DATE NOT NULL,
    firmware_version VARCHAR(10) NOT NULL,
    battery_life_days DECIMAL(3,1) NOT NULL CHECK (battery_life_days >= 0),
    sync_frequency_daily INT NOT NULL CHECK (sync_frequency_daily >= 0),
    active_hours_daily DECIMAL(3,1) NOT NULL CHECK (active_hours_daily BETWEEN 0 AND 24),
    total_steps_recorded BIGINT NOT NULL CHECK (total_steps_recorded >= 0),
    total_workouts_recorded INT NOT NULL CHECK (total_workouts_recorded >= 0),
    sleep_tracking_enabled BIT NOT NULL DEFAULT 0,
    heart_rate_monitoring_enabled BIT NOT NULL DEFAULT 0,
    gps_enabled BIT NOT NULL DEFAULT 0,
    notification_enabled BIT NOT NULL DEFAULT 0,
    device_status VARCHAR(50) NOT NULL CHECK (device_status IN ('Active', 'Inactive', 'Retired'))
);
GO

-- Add table relationships 
ALTER TABLE [dbo].[Sales]
ADD CONSTRAINT FK_Sales_Customers
FOREIGN KEY (user_id) REFERENCES [dbo].[Customers](user_id)
ON DELETE CASCADE ON UPDATE CASCADE;
GO


ALTER TABLE [dbo].[HealthMetrics]
ADD CONSTRAINT FK_HealthMetrics_Customers
FOREIGN KEY (user_id) REFERENCES [dbo].[Customers](user_id)
ON DELETE CASCADE ON UPDATE CASCADE;
GO


ALTER TABLE [dbo].[Devices]
ADD CONSTRAINT FK_Devices_Customers
FOREIGN KEY (user_id) REFERENCES [dbo].[Customers](user_id)
ON DELETE CASCADE ON UPDATE CASCADE;
GO

-- Insert Data Into Tables
USE HealthcaredataDb;
GO


INSERT INTO [dbo].[Customers] (user_id, age, gender, city, state, country, occupation, income_bracket,
                               registration_date, subscription_type)
VALUES
('TH001', 34, 'F', 'Boston', 'MA', 'USA', 'Software Engineer', '75K-100K', '2022-01-15', 'Premium'),
('TH002', 45, 'M', 'London', NULL, 'UK', 'Project Manager', '100K-150K', '2021-11-30', 'Basic'),
('TH003', 28, 'F', 'Singapore', NULL, 'SG', 'Data Analyst', '50K-75K', '2022-03-22', 'Premium'),
('TH004', 52, 'M', 'New York', 'NY', 'USA', 'CEO', '200K+', '2021-08-15', 'Enterprise'),
('TH005', 29, 'F', 'San Francisco', 'CA', 'USA', 'Product Manager', '100K-150K', '2022-02-28', 'Premium'),
('TH006', 41, 'M', 'Chicago', 'IL', 'USA', 'Sales Director', '150K-200K', '2021-12-05', 'Enterprise'),
('TH007', 33, 'F', 'Toronto', NULL, 'CA', 'Marketing Manager', '75K-100K', '2022-04-10', 'Basic'),
('TH008', 38, 'M', 'Sydney', NULL, 'AU', 'Business Analyst', '75K-100K', '2022-01-20', 'Premium'),
('TH009', 26, 'F', 'Seattle', 'WA', 'USA', 'UX Designer', '50K-75K', '2022-05-15', 'Basic'),
('TH010', 47, 'M', 'Austin', 'TX', 'USA', 'IT Director', '150K-200K', '2021-09-30', 'Enterprise'),
('TH011', 31, 'F', 'Melbourne', NULL, 'AU', 'HR Manager', '75K-100K', '2022-03-01', 'Premium'),
('TH012', 44, 'M', 'Vancouver', NULL, 'CA', 'Consultant', '100K-150K', '2021-10-15', 'Basic'),
('TH013', 36, 'F', 'Dublin', NULL, 'IE', 'Developer', '50K-75K', '2022-02-14', 'Premium'),
('TH014', 50, 'M', 'Miami', 'FL', 'USA', 'CFO', '200K+', '2021-11-01', 'Enterprise'),
('TH015', 27, 'F', 'Portland', 'OR', 'USA', 'Content Writer', 'Under 50K', '2022-06-01', 'Basic'),
('TH016', 42, 'M', 'Dallas', 'TX', 'USA', 'Sales Manager', '100K-150K', '2022-01-05', 'Premium'),
('TH017', 30, 'F', 'Manchester', NULL, 'UK', 'Teacher', '50K-75K', '2022-04-22', 'Basic'),
('TH018', 39, 'M', 'Houston', 'TX', 'USA', 'Engineer', '75K-100K', '2021-12-15', 'Premium'),
('TH019', 28, 'F', 'Paris', NULL, 'FR', 'Designer', '50K-75K', '2022-03-30', 'Basic'),
('TH020', 46, 'M', 'Denver', 'CO', 'USA', 'Architect', '100K-150K', '2021-10-30', 'Premium'),
('TH021', 32, 'F', 'Berlin', NULL, 'DE', 'Researcher', '50K-75K', '2022-02-01', 'Basic'),
('TH022', 43, 'M', 'Phoenix', 'AZ', 'USA', 'Director', '150K-200K', '2021-09-15', 'Enterprise'),
('TH023', 35, 'F', 'Mumbai', NULL, 'IN', 'Manager', '50K-75K', '2022-05-01', 'Premium'),
('TH024', 48, 'M', 'Atlanta', 'GA', 'USA', 'Executive', '150K-200K', '2021-11-15', 'Enterprise'),
('TH025', 25, 'F', 'Tokyo', NULL, 'JP', 'Analyst', 'Under 50K', '2022-06-15', 'Basic'),
('TH026', 40, 'M', 'San Diego', 'CA', 'USA', 'Developer', '75K-100K', '2022-01-10', 'Premium'),
('TH027', 34, 'F', 'Amsterdam', NULL, 'NL', 'Consultant', '75K-100K', '2022-03-15', 'Premium'),
('TH028', 51, 'M', 'Las Vegas', 'NV', 'USA', 'CEO', '200K+', '2021-08-30', 'Enterprise'),
('TH029', 29, 'F', 'Toronto', NULL, 'CA', 'Designer', '50K-75K', '2022-04-05', 'Basic'),
('TH030', 37, 'M', 'Seattle', 'WA', 'USA', 'Product Manager', '100K-150K', '2021-12-20', 'Premium'),
('TH031', 33, 'F', 'Stockholm', NULL, 'SE', 'Engineer', '75K-100K', '2022-02-15', 'Premium'),
('TH032', 45, 'M', 'Boston', 'MA', 'USA', 'Director', '150K-200K', '2021-10-01', 'Enterprise'),
('TH033', 28, 'F', 'Oslo', NULL, 'NO', 'Analyst', '50K-75K', '2022-05-20', 'Basic'),
('TH034', 44, 'M', 'Philadelphia', 'PA', 'USA', 'Manager', '100K-150K', '2021-11-20', 'Premium'),
('TH035', 31, 'F', 'Copenhagen', NULL, 'DK', 'Developer', '75K-100K', '2022-03-10', 'Premium'),
('TH036', 49, 'M', 'Portland', 'OR', 'USA', 'Executive', '150K-200K', '2021-09-01', 'Enterprise'),
('TH037', 27, 'F', 'Helsinki', NULL, 'FI', 'Designer', 'Under 50K', '2022-06-10', 'Basic'),
('TH038', 41, 'M', 'Miami', 'FL', 'USA', 'Sales Manager', '100K-150K', '2022-01-25', 'Premium'),
('TH039', 36, 'F', 'Brussels', NULL, 'BE', 'Consultant', '75K-100K', '2022-04-15', 'Premium'),
('TH040', 53, 'M', 'Chicago', 'IL', 'USA', 'CTO', '200K+', '2021-08-01', 'Enterprise'),
('TH041', 30, 'F', 'Vienna', NULL, 'AT', 'Analyst', '50K-75K', '2022-05-05', 'Basic'),
('TH042', 42, 'M', 'Houston', 'TX', 'USA', 'Director', '150K-200K', '2021-12-10', 'Enterprise'),
('TH043', 32, 'F', 'Madrid', NULL, 'ES', 'Manager', '75K-100K', '2022-02-20', 'Premium'),
('TH044', 46, 'M', 'San Francisco', 'CA', 'USA', 'Engineer', '100K-150K', '2021-10-20', 'Premium'),
('TH045', 29, 'F', 'Rome', NULL, 'IT', 'Designer', '50K-75K', '2022-03-25', 'Basic'),
('TH046', 38, 'M', 'Detroit', 'MI', 'USA', 'Manager', '75K-100K', '2022-01-30', 'Premium'),
('TH047', 35, 'F', 'Zurich', NULL, 'CH', 'Analyst', '100K-150K', '2022-04-20', 'Premium'),
('TH048', 47, 'M', 'Minneapolis', 'MN', 'USA', 'Director', '150K-200K', '2021-11-10', 'Enterprise'),
('TH049', 26, 'F', 'Barcelona', NULL, 'ES', 'Developer', 'Under 50K', '2022-06-05', 'Basic'),
('TH050', 43, 'M', 'Seattle', 'WA', 'USA', 'Product Manager', '100K-150K', '2021-12-25', 'Premium');



INSERT INTO [dbo].[Sales] (sale_id, user_id, sale_date, product_id, product_name,
                       product_category, unit_price, quantity, discount_applied,
                       total_amount, payment_method, subscription_plan, sales_channel,
                       region, sales_rep_id)
VALUES
('S001', 'TH001', '2022-01-15', 'PRO-001', 'HealthTrack Pro', 'Device', 299.99, 1, 0.0, 299.99, 'Credit Card', 'Premium', 'Online', 'Northeast', 'REP001'),
('S002', 'TH001', '2022-01-15', 'SUB-001', 'Premium Subscription', 'Subscription', 14.99, 12, 10.0, 161.89, 'Credit Card', 'Premium', 'Online', 'Northeast', 'REP001'),
('S003', 'TH001', '2022-01-15', 'ACC-001', 'Sports Band', 'Accessory', 29.99, 2, 0.0, 59.98, 'Credit Card', 'Premium', 'Online', 'Northeast', 'REP001'),
('S004', 'TH002', '2021-11-30', 'LIT-001', 'HealthTrack Lite', 'Device', 199.99, 1, 20.0, 159.99, 'PayPal', 'Basic', 'Retail', 'Europe', 'REP005'),
('S005', 'TH002', '2021-11-30', 'SUB-002', 'Basic Subscription', 'Subscription', 9.99, 12, 0.0, 119.88, 'PayPal', 'Basic', 'Retail', 'Europe', 'REP005'),
('S006', 'TH003', '2022-03-22', 'PRO-001', 'HealthTrack Pro', 'Device', 299.99, 1, 15.0, 254.99, 'Credit Card', 'Premium', 'Online', 'Asia', 'REP008'),
('S007', 'TH003', '2022-03-22', 'SUB-001', 'Premium Subscription', 'Subscription', 14.99, 12, 10.0, 161.89, 'Credit Card', 'Premium', 'Online', 'Asia', 'REP008'),
('S008', 'TH004', '2021-08-15', 'ELT-001', 'HealthTrack Elite', 'Device', 499.99, 1, 0.0, 499.99, 'Bank Transfer', 'Enterprise', 'Direct Sales', 'Northeast', 'REP002'),
('S009', 'TH004', '2021-08-15', 'SUB-003', 'Enterprise Subscription', 'Subscription', 24.99, 12, 15.0, 254.9, 'Bank Transfer', 'Enterprise', 'Direct Sales', 'Northeast', 'REP002'),
('S010', 'TH005', '2022-02-28', 'PRO-001', 'HealthTrack Pro', 'Device', 299.99, 1, 0.0, 299.99, 'Credit Card', 'Premium', 'Online', 'West', 'REP003'),
('S011', 'TH005', '2022-02-28', 'SUB-001', 'Premium Subscription', 'Subscription', 14.99, 12, 10.0, 161.89, 'Credit Card', 'Premium', 'Online', 'West', 'REP003'),
('S012', 'TH006', '2021-12-05', 'ELT-001', 'HealthTrack Elite', 'Device', 499.99, 1, 10.0, 449.99, 'Credit Card', 'Enterprise', 'Direct Sales', 'South', 'REP004'),
('S013', 'TH006', '2021-12-05', 'SUB-003', 'Enterprise Subscription', 'Subscription', 24.99, 12, 15.0, 254.9, 'Credit Card', 'Enterprise', 'Direct Sales', 'South', 'REP004'),
('S014', 'TH007', '2022-04-10', 'LIT-001', 'HealthTrack Lite', 'Device', 199.99, 1, 0.0, 199.99, 'PayPal', 'Basic', 'Online', 'Canada', 'REP006'),
('S015', 'TH007', '2022-04-10', 'SUB-002', 'Basic Subscription', 'Subscription', 9.99, 12, 0.0, 119.88, 'PayPal', 'Basic', 'Online', 'Canada', 'REP006'),
('S016', 'TH008', '2022-01-20', 'PRO-001', 'HealthTrack Pro', 'Device', 299.99, 1, 0.0, 299.99, 'Credit Card', 'Premium', 'Online', 'Australia', 'REP009'),
('S017', 'TH008', '2022-01-20', 'SUB-001', 'Premium Subscription', 'Subscription', 14.99, 12, 10.0, 161.89, 'Credit Card', 'Premium', 'Online', 'Australia', 'REP009'),
('S018', 'TH009', '2022-05-15', 'LIT-001', 'HealthTrack Lite', 'Device', 199.99, 1, 25.0, 149.99, 'Credit Card', 'Basic', 'Retail', 'West', 'REP003'),
('S019', 'TH009', '2022-05-15', 'SUB-002', 'Basic Subscription', 'Subscription', 9.99, 12, 0.0, 119.88, 'Credit Card', 'Basic', 'Retail', 'West', 'REP003'),
('S020', 'TH010', '2021-09-30', 'ELT-001', 'HealthTrack Elite', 'Device', 499.99, 1, 0.0, 499.99, 'Bank Transfer', 'Enterprise', 'Direct Sales', 'South', 'REP004'),
('S021', 'TH011', '2022-03-01', 'PRO-001', 'HealthTrack Pro', 'Device', 299.99, 1, 5.0, 284.99, 'Credit Card', 'Premium', 'Online', 'Australia', 'REP009'),
('S022', 'TH011', '2022-03-01', 'SUB-001', 'Premium Subscription', 'Subscription', 14.99, 12, 10.0, 161.89, 'Credit Card', 'Premium', 'Online', 'Australia', 'REP009'),
('S023', 'TH012', '2021-10-15', 'LIT-001', 'HealthTrack Lite', 'Device', 199.99, 1, 15.0, 169.99, 'PayPal', 'Basic', 'Online', 'Canada', 'REP006'),
('S024', 'TH012', '2021-10-15', 'SUB-002', 'Basic Subscription', 'Subscription', 9.99, 12, 0.0, 119.88, 'PayPal', 'Basic', 'Online', 'Canada', 'REP006'),
('S025', 'TH013', '2022-02-14', 'PRO-001', 'HealthTrack Pro', 'Device', 299.99, 1, 0.0, 299.99, 'Credit Card', 'Premium', 'Retail', 'Europe', 'REP005'),
('S026', 'TH013', '2022-02-14', 'SUB-001', 'Premium Subscription', 'Subscription', 14.99, 12, 10.0, 161.89, 'Credit Card', 'Premium', 'Retail', 'Europe', 'REP005'),
('S027', 'TH014', '2021-11-01', 'ELT-001', 'HealthTrack Elite', 'Device', 499.99, 1, 10.0, 449.99, 'Bank Transfer', 'Enterprise', 'Direct Sales', 'Northeast', 'REP002'),
('S028', 'TH014', '2021-11-01', 'SUB-003', 'Enterprise Subscription', 'Subscription', 24.99, 12, 15.0, 254.9, 'Bank Transfer', 'Enterprise', 'Direct Sales', 'Northeast', 'REP002'),
('S029', 'TH015', '2022-06-01', 'LIT-001', 'HealthTrack Lite', 'Device', 199.99, 1, 20.0, 159.99, 'Credit Card', 'Basic', 'Online', 'West', 'REP003'),
('S030', 'TH015', '2022-06-01', 'SUB-002', 'Basic Subscription', 'Subscription', 9.99, 12, 0.0, 119.88, 'Credit Card', 'Basic', 'Online', 'West', 'REP003'),
('S031', 'TH016', '2022-01-05', 'PRO-001', 'HealthTrack Pro', 'Device', 299.99, 1, 0.0, 299.99, 'Credit Card', 'Premium', 'Online', 'South', 'REP004'),
('S032', 'TH016', '2022-01-05', 'SUB-001', 'Premium Subscription', 'Subscription', 14.99, 12, 10.0, 161.89, 'Credit Card', 'Premium', 'Online', 'South', 'REP004'),
('S033', 'TH016', '2022-01-05', 'ACC-002', 'Charging Dock', 'Accessory', 39.99, 1, 0.0, 39.99, 'Credit Card', 'Premium', 'Online', 'South', 'REP004'),
('S034', 'TH017', '2022-04-22', 'LIT-001', 'HealthTrack Lite', 'Device', 199.99, 1, 15.0, 169.99, 'PayPal', 'Basic', 'Retail', 'Europe', 'REP005'),
('S035', 'TH017', '2022-04-22', 'SUB-002', 'Basic Subscription', 'Subscription', 9.99, 12, 0.0, 119.88, 'PayPal', 'Basic', 'Retail', 'Europe', 'REP005'),
('S036', 'TH018', '2021-12-15', 'PRO-001', 'HealthTrack Pro', 'Device', 299.99, 1, 5.0, 284.99, 'Credit Card', 'Premium', 'Online', 'South', 'REP004'),
('S037', 'TH018', '2021-12-15', 'SUB-001', 'Premium Subscription', 'Subscription', 14.99, 12, 10.0, 161.89, 'Credit Card', 'Premium', 'Online', 'South', 'REP004'),
('S038', 'TH019', '2022-03-30', 'LIT-001', 'HealthTrack Lite', 'Device', 199.99, 1, 0.0, 199.99, 'Credit Card', 'Basic', 'Retail', 'Europe', 'REP005'),
('S039', 'TH019', '2022-03-30', 'SUB-002', 'Basic Subscription', 'Subscription', 9.99, 12, 0.0, 119.88, 'Credit Card', 'Basic', 'Retail', 'Europe', 'REP005'),
('S040', 'TH020', '2021-10-30', 'PRO-001', 'HealthTrack Pro', 'Device', 299.99, 1, 0.0, 299.99, 'Credit Card', 'Premium', 'Online', 'West', 'REP003'),
('S041', 'TH020', '2021-10-30', 'SUB-001', 'Premium Subscription', 'Subscription', 14.99, 12, 10.0, 161.89, 'Credit Card', 'Premium', 'Online', 'West', 'REP003'),
('S042', 'TH021', '2022-02-01', 'LIT-001', 'HealthTrack Lite', 'Device', 199.99, 1, 20.0, 159.99, 'PayPal', 'Basic', 'Online', 'Europe', 'REP005'),
('S043', 'TH021', '2022-02-01', 'SUB-002', 'Basic Subscription', 'Subscription', 9.99, 12, 0.0, 119.88, 'PayPal', 'Basic', 'Online', 'Europe', 'REP005'),
('S044', 'TH022', '2021-09-15', 'ELT-001', 'HealthTrack Elite', 'Device', 499.99, 1, 0.0, 499.99, 'Bank Transfer', 'Enterprise', 'Direct Sales', 'West', 'REP003'),
('S045', 'TH022', '2021-09-15', 'SUB-003', 'Enterprise Subscription', 'Subscription', 24.99, 12, 15.0, 254.9, 'Bank Transfer', 'Enterprise', 'Direct Sales', 'West', 'REP003'),
('S046', 'TH023', '2022-05-01', 'PRO-001', 'HealthTrack Pro', 'Device', 299.99, 1, 10.0, 269.99, 'Credit Card', 'Premium', 'Online', 'Asia', 'REP008'),
('S047', 'TH023', '2022-05-01', 'SUB-001', 'Premium Subscription', 'Subscription', 14.99, 12, 10.0, 161.89, 'Credit Card', 'Premium', 'Online', 'Asia', 'REP008'),
('S048', 'TH024', '2021-11-15', 'ELT-001', 'HealthTrack Elite', 'Device', 499.99, 1, 5.0, 474.99, 'Bank Transfer', 'Enterprise', 'Direct Sales', 'South', 'REP004'),
('S049', 'TH024', '2021-11-15', 'SUB-003', 'Enterprise Subscription', 'Subscription', 24.99, 12, 15.0, 254.9, 'Bank Transfer', 'Enterprise', 'Direct Sales', 'South', 'REP004'),
('S050', 'TH025', '2022-06-15', 'LIT-001', 'HealthTrack Lite', 'Device', 199.99, 1, 25.0, 149.99, 'Credit Card', 'Basic', 'Retail', 'Asia', 'REP008');



INSERT INTO [dbo].[HealthMetrics] (record_id, user_id, month_date, avg_heart_rate,
                               avg_resting_heart_rate, avg_daily_steps, avg_sleep_hours,
                               avg_deep_sleep_hours, avg_daily_calories, avg_exercise_minutes,
                               avg_stress_level, avg_blood_oxygen, total_active_days,
                               workout_frequency, achievement_rate)
VALUES
('MHM001', 'TH001', '2023-06-01', 73, 62, 11345, 7.2, 2.0, 2267, 42, 3.4, 98.3, 28, 4, 0.85),
('MHM002', 'TH002', '2023-06-01', 69, 60, 8876, 6.5, 1.5, 1898, 26, 3.8, 97.9, 25, 3, 0.72),
('MHM003', 'TH003', '2023-06-01', 83, 68, 15845, 8.1, 2.4, 2876, 66, 2.3, 98.5, 30, 6, 0.95),
('MHM004', 'TH004', '2023-06-01', 71, 63, 12456, 7.5, 2.1, 2345, 45, 2.8, 98.2, 27, 4, 0.82),
('MHM005', 'TH005', '2023-06-01', 75, 64, 13567, 7.8, 2.2, 2567, 52, 3.1, 98.4, 29, 5, 0.88),
('MHM006', 'TH006', '2023-06-01', 78, 65, 14234, 7.6, 2.3, 2678, 58, 2.5, 98.6, 30, 5, 0.92),
('MHM007', 'TH007', '2023-06-01', 68, 59, 7865, 6.3, 1.4, 1756, 22, 3.9, 97.8, 24, 2, 0.68),
('MHM008', 'TH008', '2023-06-01', 74, 63, 12789, 7.4, 2.1, 2432, 48, 3.0, 98.3, 28, 4, 0.86),
('MHM009', 'TH009', '2023-06-01', 67, 58, 7234, 6.1, 1.3, 1645, 20, 4.1, 97.7, 22, 2, 0.65),
('MHM010', 'TH010', '2023-06-01', 76, 64, 13987, 7.7, 2.2, 2745, 56, 2.6, 98.5, 29, 5, 0.9),
('MHM011', 'TH011', '2023-06-01', 72, 61, 11234, 7.3, 2.0, 2234, 44, 3.3, 98.2, 27, 4, 0.84),
('MHM012', 'TH012', '2023-06-01', 70, 60, 9123, 6.6, 1.6, 1945, 28, 3.7, 98.0, 25, 3, 0.75),
('MHM013', 'TH013', '2023-06-01', 73, 62, 11678, 7.4, 2.1, 2345, 46, 3.2, 98.3, 28, 4, 0.86),
('MHM014', 'TH014', '2023-06-01', 77, 65, 14123, 7.8, 2.3, 2789, 60, 2.4, 98.6, 30, 5, 0.93),
('MHM015', 'TH015', '2023-06-01', 66, 57, 6987, 6.0, 1.2, 1587, 18, 4.2, 97.6, 21, 2, 0.62),
('MHM016', 'TH016', '2023-06-01', 74, 63, 12345, 7.5, 2.1, 2456, 50, 3.0, 98.4, 28, 4, 0.87),
('MHM017', 'TH017', '2023-06-01', 69, 59, 8234, 6.4, 1.4, 1823, 24, 3.8, 97.9, 24, 3, 0.71),
('MHM018', 'TH018', '2023-06-01', 75, 64, 13234, 7.6, 2.2, 2634, 54, 2.7, 98.5, 29, 5, 0.89),
('MHM019', 'TH019', '2023-06-01', 68, 58, 7645, 6.2, 1.3, 1698, 21, 4.0, 97.8, 23, 2, 0.67),
('MHM020', 'TH020', '2023-06-01', 73, 62, 11897, 7.3, 2.0, 2378, 47, 3.1, 98.3, 28, 4, 0.85),
('MHM021', 'TH021', '2023-06-01', 67, 58, 7456, 6.1, 1.3, 1676, 20, 4.1, 97.7, 22, 2, 0.66),
('MHM022', 'TH022', '2023-06-01', 78, 66, 14567, 7.9, 2.4, 2845, 62, 2.3, 98.7, 30, 6, 0.94),
('MHM023', 'TH023', '2023-06-01', 72, 61, 11123, 7.2, 2.0, 2245, 43, 3.4, 98.2, 27, 4, 0.83),
('MHM024', 'TH024', '2023-06-01', 77, 65, 14234, 7.8, 2.3, 2798, 59, 2.5, 98.6, 30, 5, 0.92),
('MHM025', 'TH025', '2023-06-01', 66, 57, 6876, 6.0, 1.2, 1565, 17, 4.3, 97.6, 20, 2, 0.61),
('MHM026', 'TH026', '2023-06-01', 74, 63, 12567, 7.5, 2.1, 2467, 51, 2.9, 98.4, 28, 4, 0.88),
('MHM027', 'TH027', '2023-06-01', 73, 62, 11789, 7.4, 2.1, 2356, 45, 3.2, 98.3, 27, 4, 0.85),
('MHM028', 'TH028', '2023-06-01', 76, 64, 13876, 7.7, 2.2, 2723, 57, 2.6, 98.5, 29, 5, 0.91),
('MHM029', 'TH029', '2023-06-01', 68, 59, 7987, 6.3, 1.4, 1787, 23, 3.9, 97.8, 24, 2, 0.69),
('MHM030', 'TH030', '2023-06-01', 75, 64, 13123, 7.6, 2.2, 2645, 55, 2.8, 98.5, 29, 5, 0.9),
('MHM031', 'TH031', '2023-06-01', 73, 62, 11456, 7.3, 2.0, 2289, 44, 3.3, 98.3, 28, 4, 0.84),
('MHM032', 'TH032', '2023-06-01', 77, 65, 14345, 7.8, 2.3, 2812, 61, 2.4, 98.6, 30, 5, 0.93),
('MHM033', 'TH033', '2023-06-01', 67, 58, 7345, 6.2, 1.3, 1654, 19, 4.1, 97.7, 22, 2, 0.65),
('MHM034', 'TH034', '2023-06-01', 74, 63, 12678, 7.5, 2.1, 2478, 52, 2.9, 98.4, 28, 4, 0.87),
('MHM035', 'TH035', '2023-06-01', 73, 62, 11567, 7.4, 2.1, 2334, 46, 3.2, 98.3, 27, 4, 0.85),
('MHM036', 'TH036', '2023-06-01', 78, 66, 14789, 7.9, 2.4, 2867, 63, 2.3, 98.7, 30, 6, 0.94),
('MHM037', 'TH037', '2023-06-01', 66, 57, 6789, 6.0, 1.2, 1543, 18, 4.2, 97.6, 21, 2, 0.62),
('MHM038', 'TH038', '2023-06-01', 75, 64, 13345, 7.6, 2.2, 2656, 56, 2.7, 98.5, 29, 5, 0.89),
('MHM039', 'TH039', '2023-06-01', 73, 62, 11678, 7.4, 2.1, 2367, 47, 3.1, 98.3, 28, 4, 0.86),
('MHM040', 'TH040', '2023-06-01', 77, 65, 14456, 7.8, 2.3, 2834, 62, 2.4, 98.6, 30, 5, 0.93),
('MHM041', 'TH041', '2023-06-01', 68, 59, 7876, 6.3, 1.4, 1765, 22, 4.0, 97.8, 23, 2, 0.68),
('MHM042', 'TH042', '2023-06-01', 78, 66, 14678, 7.9, 2.4, 2856, 64, 2.3, 98.7, 30, 6, 0.95),
('MHM043', 'TH043', '2023-06-01', 74, 63, 12234, 7.5, 2.1, 2445, 49, 3.0, 98.4, 28, 4, 0.87),
('MHM044', 'TH044', '2023-06-01', 75, 64, 13234, 7.6, 2.2, 2623, 53, 2.8, 98.5, 29, 5, 0.89),
('MHM045', 'TH045', '2023-06-01', 67, 58, 7123, 6.1, 1.3, 1632, 19, 4.1, 97.7, 22, 2, 0.64),
('MHM046', 'TH046', '2023-06-01', 74, 63, 12456, 7.5, 2.1, 2467, 51, 2.9, 98.4, 28, 4, 0.87),
('MHM047', 'TH047', '2023-06-01', 75, 64, 13123, 7.6, 2.2, 2634, 54, 2.8, 98.5, 29, 5, 0.9),
('MHM048', 'TH048', '2023-06-01', 77, 65, 14234, 7.8, 2.3, 2789, 60, 2.4, 98.6, 30, 5, 0.93),
('MHM049', 'TH049', '2023-06-01', 66, 57, 6876, 6.0, 1.2, 1576, 18, 4.2, 97.6, 21, 2, 0.63),
('MHM050', 'TH050', '2023-06-01', 74, 63, 12345, 7.5, 2.1, 2456, 50, 3.0, 98.4, 28, 4, 0.87);



INSERT INTO [dbo].[Devices] (device_id, user_id, device_type, purchase_date, last_sync_date,
                         firmware_version, battery_life_days, sync_frequency_daily,
                         active_hours_daily, total_steps_recorded, total_workouts_recorded,
                         sleep_tracking_enabled, heart_rate_monitoring_enabled, gps_enabled,
                         notification_enabled, device_status)
VALUES
('DEV001', 'TH001', 'HealthTrack Pro', '2022-01-15', '2023-06-15', 'v3.2.1', 5.2, 24, 16.5, 2345678, 156, 1, 1, 1, 1, 'Active'),
('DEV002', 'TH002', 'HealthTrack Lite', '2021-11-30', '2023-06-15', 'v3.1.0', 7.0, 12, 12.8, 1234567, 89, 1, 1, 0, 1, 'Active'),
('DEV003', 'TH003', 'HealthTrack Pro', '2022-03-22', '2023-06-15', 'v3.2.1', 4.8, 24, 18.2, 1876543, 201, 1, 1, 1, 1, 'Active'),
('DEV004', 'TH004', 'HealthTrack Elite', '2021-08-15', '2023-06-15', 'v3.2.1', 4.5, 48, 14.7, 3456789, 312, 1, 1, 1, 1, 'Active'),
('DEV005', 'TH005', 'HealthTrack Pro', '2022-02-28', '2023-06-15', 'v3.2.1', 5.0, 24, 15.9, 2123456, 178, 1, 1, 1, 1, 'Active'),
('DEV006', 'TH006', 'HealthTrack Elite', '2021-12-05', '2023-06-15', 'v3.2.1', 4.6, 48, 13.5, 4567890, 245, 1, 1, 1, 1, 'Active'),
('DEV007', 'TH007', 'HealthTrack Lite', '2022-04-10', '2023-06-15', 'v3.1.0', 6.8, 12, 11.2, 987654, 67, 1, 1, 0, 1, 'Active'),
('DEV008', 'TH008', 'HealthTrack Pro', '2022-01-20', '2023-06-15', 'v3.2.1', 5.1, 24, 17.3, 2789012, 198, 1, 1, 1, 1, 'Active'),
('DEV009', 'TH009', 'HealthTrack Lite', '2022-05-15', '2023-06-14', 'v3.1.0', 7.2, 12, 10.5, 654321, 45, 1, 1, 0, 1, 'Inactive'),
('DEV010', 'TH010', 'HealthTrack Elite', '2021-09-30', '2023-06-15', 'v3.2.1', 4.4, 48, 16.8, 3901234, 289, 1, 1, 1, 1, 'Active'),
('DEV011', 'TH011', 'HealthTrack Pro', '2022-03-01', '2023-06-15', 'v3.2.1', 5.3, 24, 15.4, 2345678, 167, 1, 1, 1, 1, 'Active'),
('DEV012', 'TH012', 'HealthTrack Lite', '2021-10-15', '2023-06-15', 'v3.1.0', 6.9, 12, 11.8, 1123456, 78, 1, 1, 0, 1, 'Active'),
('DEV013', 'TH013', 'HealthTrack Pro', '2022-02-14', '2023-06-15', 'v3.2.1', 4.9, 24, 16.7, 2567890, 187, 1, 1, 1, 1, 'Active'),
('DEV014', 'TH014', 'HealthTrack Elite', '2021-11-01', '2023-06-15', 'v3.2.1', 4.7, 48, 15.2, 4123456, 298, 1, 1, 1, 1, 'Active'),
('DEV015', 'TH015', 'HealthTrack Lite', '2022-06-01', '2023-06-13', 'v3.1.0', 7.1, 12, 9.8, 456789, 34, 1, 1, 0, 1, 'Inactive'),
('DEV016', 'TH016', 'HealthTrack Pro', '2022-01-05', '2023-06-15', 'v3.2.1', 5.0, 24, 16.1, 2234567, 165, 1, 1, 1, 1, 'Active'),
('DEV017', 'TH017', 'HealthTrack Lite', '2022-04-22', '2023-06-15', 'v3.1.0', 6.7, 12, 11.5, 876543, 56, 1, 1, 0, 1, 'Active'),
('DEV018', 'TH018', 'HealthTrack Pro', '2021-12-15', '2023-06-15', 'v3.2.1', 5.2, 24, 17.8, 2901234, 211, 1, 1, 1, 1, 'Active'),
('DEV019', 'TH019', 'HealthTrack Lite', '2022-03-30', '2023-06-15', 'v3.1.0', 7.0, 12, 10.9, 765432, 43, 1, 1, 0, 1, 'Active'),
('DEV020', 'TH020', 'HealthTrack Pro', '2021-10-30', '2023-06-15', 'v3.2.1', 5.1, 24, 15.6, 2445678, 177, 1, 1, 1, 1, 'Active'),
('DEV021', 'TH021', 'HealthTrack Lite', '2022-02-01', '2023-06-15', 'v3.1.0', 6.9, 12, 11.1, 998765, 69, 1, 1, 0, 1, 'Active'),
('DEV022', 'TH022', 'HealthTrack Elite', '2021-09-15', '2023-06-15', 'v3.2.1', 4.5, 48, 16.4, 3789012, 267, 1, 1, 1, 1, 'Active'),
('DEV023', 'TH023', 'HealthTrack Pro', '2022-05-01', '2023-06-15', 'v3.2.1', 5.0, 24, 15.8, 2223456, 156, 1, 1, 1, 1, 'Active'),
('DEV024', 'TH024', 'HealthTrack Elite', '2021-11-15', '2023-06-15', 'v3.2.1', 4.6, 48, 14.9, 4234567, 301, 1, 1, 1, 1, 'Active'),
('DEV025', 'TH025', 'HealthTrack Lite', '2022-06-15', '2023-06-14', 'v3.1.0', 7.2, 12, 9.5, 543210, 38, 1, 1, 0, 1, 'Inactive'),
('DEV026', 'TH026', 'HealthTrack Pro', '2022-01-10', '2023-06-15', 'v3.2.1', 5.3, 24, 16.9, 2678901, 189, 1, 1, 1, 1, 'Active'),
('DEV027', 'TH027', 'HealthTrack Pro', '2022-03-15', '2023-06-15', 'v3.2.1', 4.9, 24, 17.1, 2456789, 182, 1, 1, 1, 1, 'Active'),
('DEV028', 'TH028', 'HealthTrack Elite', '2021-08-30', '2023-06-15', 'v3.2.1', 4.4, 48, 15.7, 4012345, 278, 1, 1, 1, 1, 'Active'),
('DEV029', 'TH029', 'HealthTrack Lite', '2022-04-05', '2023-06-15', 'v3.1.0', 6.8, 12, 11.3, 887654, 58, 1, 1, 0, 1, 'Active'),
('DEV030', 'TH030', 'HealthTrack Pro', '2021-12-20', '2023-06-15', 'v3.2.1', 5.1, 24, 16.2, 2567890, 188, 1, 1, 1, 1, 'Active'),
('DEV031', 'TH031', 'HealthTrack Pro', '2022-02-15', '2023-06-15', 'v3.2.1', 5.2, 24, 15.9, 2345678, 171, 1, 1, 1, 1, 'Active'),
('DEV032', 'TH032', 'HealthTrack Elite', '2021-10-01', '2023-06-15', 'v3.2.1', 4.7, 48, 14.8, 3987654, 289, 1, 1, 1, 1, 'Active'),
('DEV033', 'TH033', 'HealthTrack Lite', '2022-05-20', '2023-06-15', 'v3.1.0', 7.1, 12, 10.7, 654321, 47, 1, 1, 0, 1, 'Active'),
('DEV034', 'TH034', 'HealthTrack Pro', '2021-11-20', '2023-06-15', 'v3.2.1', 5.0, 24, 16.6, 2789012, 198, 1, 1, 1, 1, 'Active'),
('DEV035', 'TH035', 'HealthTrack Pro', '2022-03-10', '2023-06-15', 'v3.2.1', 4.8, 24, 17.4, 2567890, 187, 1, 1, 1, 1, 'Active'),
('DEV036', 'TH036', 'HealthTrack Elite', '2021-09-01', '2023-06-15', 'v3.2.1', 4.5, 48, 15.1, 4234567, 299, 1, 1, 1, 1, 'Active'),
('DEV037', 'TH037', 'HealthTrack Lite', '2022-06-10', '2023-06-14', 'v3.1.0', 7.0, 12, 9.9, 567890, 41, 1, 1, 0, 1, 'Inactive'),
('DEV038', 'TH038', 'HealthTrack Pro', '2022-01-25', '2023-06-15', 'v3.2.1', 5.1, 24, 16.3, 2456789, 176, 1, 1, 1, 1, 'Active'),
('DEV039', 'TH039', 'HealthTrack Pro', '2022-04-15', '2023-06-15', 'v3.2.1', 5.0, 24, 15.7, 2345678, 169, 1, 1, 1, 1, 'Active'),
('DEV040', 'TH040', 'HealthTrack Elite', '2021-08-01', '2023-06-15', 'v3.2.1', 4.6, 48, 14.6, 4123456, 295, 1, 1, 1, 1, 'Active'),
('DEV041', 'TH041', 'HealthTrack Lite', '2022-05-05', '2023-06-15', 'v3.1.0', 6.9, 12, 11.4, 876543, 57, 1, 1, 0, 1, 'Active'),
('DEV042', 'TH042', 'HealthTrack Elite', '2021-12-10', '2023-06-15', 'v3.2.1', 4.4, 48, 15.3, 3901234, 276, 1, 1, 1, 1, 'Active'),
('DEV043', 'TH043', 'HealthTrack Pro', '2022-02-20', '2023-06-15', 'v3.2.1', 5.2, 24, 16.8, 2567890, 184, 1, 1, 1, 1, 'Active'),
('DEV044', 'TH044', 'HealthTrack Pro', '2021-10-20', '2023-06-15', 'v3.2.1', 5.1, 24, 15.5, 2678901, 191, 1, 1, 1, 1, 'Active'),
('DEV045', 'TH045', 'HealthTrack Lite', '2022-03-25', '2023-06-15', 'v3.1.0', 7.2, 12, 10.8, 765432, 49, 1, 1, 0, 1, 'Active'),
('DEV046', 'TH046', 'HealthTrack Pro', '2022-01-30', '2023-06-15', 'v3.2.1', 4.9, 24, 17.2, 2456789, 179, 1, 1, 1, 1, 'Active'),
('DEV047', 'TH047', 'HealthTrack Pro', '2022-04-20', '2023-06-15', 'v3.2.1', 5.0, 24, 16.4, 2567890, 186, 1, 1, 1, 1, 'Active'),
('DEV048', 'TH048', 'HealthTrack Elite', '2021-11-10', '2023-06-15', 'v3.2.1', 4.5, 48, 15.0, 4012345, 287, 1, 1, 1, 1, 'Active'),
('DEV049', 'TH049', 'HealthTrack Lite', '2022-06-05', '2023-06-14', 'v3.1.0', 7.1, 12, 10.2, 654321, 44, 1, 1, 0, 1, 'Inactive'),
('DEV050', 'TH050', 'HealthTrack Pro', '2021-12-25', '2023-06-15', 'v3.2.1', 5.3, 24, 16.0, 2789012, 197, 1, 1, 1, 1, 'Active');


--1. DATA QUALITY HARDENING
--Sales Table: Add a persisted column to Sales table to show that total amount is correct.
USE HealthcaredataDb;
GO

ALTER TABLE [dbo].[Sales]
ADD total_amount_calculation AS 
   (CONVERT(DECIMAL(10,2), 
    ROUND(unit_price * quantity * (1 - ISNULL(discount_applied,0)/100.0),2))
) PERSISTED;

IF NOT EXISTS (SELECT 1 FROM sys.check_constraints WHERE name = 'CK_Sales_Totalamountcheck')
BEGIN 
     ALTER TABLE [dbo].[Sales]
     ADD CONSTRAINT CK_Sales_Totalamountcheck
     CHECK (total_amount = total_amount_calculation);
END
GO

--2. INDEXING
--Sales table to faster access to common data
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Sales_User_Date' AND object_id = OBJECT_ID('dbo.Sales'))
CREATE NONCLUSTERED INDEX IX_Sales_User_Date
ON dbo.Sales(user_id, sale_date)
INCLUDE (product_name, product_id, product_category, total_amount)
GO

--Healthmetrics table to faster access to user/month
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_user_month-healthmetrics' AND object_id = OBJECT_ID('dbo.HealthMetrics'))
CREATE NONCLUSTERED INDEX IX_user_month_healthmetrics 
ON dbo.HealthMetrics(user_id, month_date)
INCLUDE (avg_heart_rate, avg_blood_oxygen, avg_daily_steps, avg_sleep_hours, achievement_rate);
GO

--Device table: faster access to user/device details
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_user_active_device' AND object_id = OBJECT_ID('dbo.Devices'))
CREATE NONCLUSTERED INDEX IX_user_active_device
ON dbo.Devices(user_id)
INCLUDE (device_status, device_type, last_sync_date);
GO

--3. TABLE PARTITIONING
--Step 1: Partition function (Define a range of values, for example range of years)
IF NOT EXISTS (
               SELECT 1 
               FROM sys.partition_functions WHERE name = 'PF_year')
               CREATE PARTITION FUNCTION PF_year (INT)
               AS RANGE RIGHT FOR VALUES (2021,2022,2023,2024,2025);
GO

IF NOT EXISTS (
               SELECT 1 
               FROM sys.partition_schemes WHERE name = 'PS_year')
               CREATE PARTITION SCHEME PS_year 
               AS partition PF_year ALL TO ([PRIMARY]);
GO


--Step 2: Remove Clustered Index on primary key and convert it to Nonclustered index to make database ready for partitioning (Sales Table)
DECLARE @pkSales sysname;
SELECT @pkSales = kc.name
FROM sys.key_constraints kc
JOIN sys.tables t ON kc.parent_object_id = t.object_id
WHERE t.name = 'Sales' AND kc.[type] = 'PK';
PRINT @pkSales


IF EXISTS (
           SELECT 1 
           FROM sys.indexes i
           JOIN sys.key_constraints kc ON kc.parent_object_id = i.object_id AND kc.unique_index_id = i.index_id
           JOIN sys.tables t ON t.object_id = i.object_id
           WHERE t.name = 'Sales' AND i.[type] = 1
)
BEGIN
    -- Drop Primary Key and Create Nonclustered Index on sale_id
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'ALTER TABLE dbo.Sales DROP CONSTRAINT ' + QUOTENAME(@pkSales) + N';';
    EXEC sp_executesql @sql;

    ALTER TABLE dbo.Sales
    ADD CONSTRAINT PK_Sales PRIMARY KEY NONCLUSTERED (sale_id);
END;


--Step 3:Create Clustered Index on Primary Keys on new tables on partition scheme (sales_id, sale_date)
IF COL_LENGTH ('dbo.Sales','sale_year') IS NULL
BEGIN
     ALTER TABLE dbo.Sales
     ADD sales_year AS YEAR(sale_date) PERSISTED;
END
GO
IF NOT EXISTS (
               SELECT 1
               FROM sys.indexes 
               WHERE object_id = OBJECT_ID ('dbo.Sales') AND name = 'IX_SalesID_SaleDate'
)
BEGIN
     CREATE CLUSTERED INDEX IX_SalesID_SaleDate
     ON dbo.Sales (sale_date, sale_id)
     ON PS_year (sales_date);
END
ELSE
BEGIN
     ALTER INDEX IX_SalesID_SaleDate ON dbo.Sales
     REBUILD PARTITION = ALL WITH (ONLINE = ON);
END
GO

--4. ROW_LEVEL SECURITY (RLS) IMPLEMENTATION
--Remove function if it already exists
IF OBJECT_ID ('dbo.fnRegionPredicate') IS NOT NULL 
DROP FUNCTION dbo.fnRegionPredicate;
GO
--Create Predictate Function
CREATE FUNCTION dbo.fnRegionPredicate (@region AS NVARCHAR(50))
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN SELECT 1 AS fn_result
WHERE @region = CAST(SESSION_CONTEXT (N'region') AS VARCHAR(50));
GO

--Apply Security Policy
USE HealthcaredataDb;
GO

IF EXISTS (
           SELECT 1 FROM sys.security_policies 
           WHERE name = 'RowLevelSecurity_Region_Sales')
           DROP SECURITY POLICY RowLevelSecurity_Region_Sales;
GO

CREATE SECURITY POLICY RowLevelSecurity_Region_Sales
ADD FILTER PREDICATE dbo.fnRegionPredicate(region) ON dbo.Sales
WITH (STATE = ON);
GO


--Test the Security Policy
EXEC sys.sp_set_session_context @key = N'region', @value = N'West'

SELECT region, sale_date
FROM dbo.Sales;


--5. SYSTEM_VERSIONED TEMPORAL TABLES 
--Create system_versioned temporal table for HealthMetrics Table (dbo.HealthMetrics)
--Add columns (ValidFrom and ValidTo)
ALTER TABLE dbo.Sales
     ADD 
     ValidFrom datetime2 NOT NULL DEFAULT SYSUTCDATETIME(),
     ValidTo datetime2 NOT NULL DEFAULT CONVERT(datetime2, '9999-12-31 23:59:59.999999');

--Update all rows consistent values
UPDATE dbo.Sales
SET ValidFrom = SYSUTCDATETIME(),
    ValidTo = CONVERT(datetime2, '9999-12-31 23:59:59.9999999');

--Add Period Time
ALTER TABLE dbo.Sales
ADD PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo);

--Enable System Versioning Table
IF NOT EXISTS (
               SELECT 1
               FROM sys.tables t
               JOIN sys.periods p ON t.object_id = p.object_id
               WHERE t.name = 'Sales' AND t.temporal_type = 2)
BEGIN
     ALTER TABLE dbo.Sales
     SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.Sales_History, DATA_CONSISTENCY_CHECK = ON));
END
GO
   

--In this example, the code would check if system versioned temporal table is working correctly or not.
--First Step: check if system versioning table is enabled.
SELECT
     t.name AS TableName,
     t.temporal_type_desc AS TemporalType,
     h.name AS HistoryTableName
FROM sys.tables t
LEFT JOIN sys.tables h ON t.history_table_id = h.object_id
WHERE t.name = 'Sales';

--Second Step: Query Data
--Current data
USE HealthcaredataDb;
GO

SELECT * 
FROM dbo.Sales;

--Historical data
SELECT *
FROM dbo.Sales
FOR SYSTEM_TIME AS OF '2025-08-01T10:00:00';

--All versions for auditing
SELECT *
FROM dbo.Sales
FOR SYSTEM_TIME ALL
ORDER BY ValidFrom;

--6. CHANGE DATA CAPTURE (CDC) : SUPPORT INCREMENTAL ETL
--Enable CDC at Database Level
USE HealthcaredataDb;
EXEC sys.sp_cdc_enable_db;

--Enable CDC on Customers Table
--Check if it already exists or not
IF NOT EXISTS (
               SELECT 1 
               FROM sys.tables
               WHERE name = 'Sales' AND is_tracked_by_cdc = 1
)
BEGIN
     EXEC sys.sp_cdc_enable_table
     @source_schema = N'dbo',
     @source_name = N'Sales',
     @role_name = NULL,
     @supports_net_changes = 1;
END
GO

--Verify CDC is enabled and working properly
SELECT name, is_cdc_enabled
FROM sys.databases
WHERE database_id = DB_ID('HealthcaredataDb'); 

--Check our CDC
EXEC sys.sp_cdc_help_change_data_capture 
     @source_schema = 'dbo', 
     @source_name = 'Sales';

--Change data in the Customers table
USE HealthcaredataDb;
GO

UPDATE dbo.Sales
SET product_name = 'Sports Band' 
WHERE sale_id = 'S013';
                             
--Check CDC table
SELECT * FROM cdc.dbo_Sales_CT;


--7. SET UP SQL SERVER AUDIT
IF OBJECT_ID('dbo.DeviceAudit','U') IS NULL
CREATE TABLE dbo.DeviceAudit (
                              audit_id bigint IDENTITY(1,1) PRIMARY KEY,
                              device_id varchar(10) NOT NULL,
                              user_id varchar(10) NOT NULL,
                              change_time datetime2 NOT NULL DEFAULT sysdatetime(),
                              change_user sysname NULL,
                              old_version varchar(10) NULL,
                              new_version varchar(10) NULL,
                              old_status varchar(50) NULL,
                              new_status varchar(50) NULL
);
GO

USE HealthcaredataDb;
GO

IF OBJECT_ID('dbo.trg_Devices_Audit','TR') IS NOT NULL 
DROP TRIGGER dbo.trg_Devices_Audit;
GO
CREATE TRIGGER dbo.trg_Devices_Audit
ON dbo.Devices
AFTER UPDATE
AS
BEGIN
SET NOCOUNT ON;
INSERT dbo.DeviceAudit(device_id, user_id, change_time, change_user, old_version, new_version, old_status, new_status)
SELECT i.device_id, i.user_id, SYSDATETIME(), SUSER_SNAME(), d.firmware_version, i.firmware_version, d.device_status, i.device_status
FROM inserted i
JOIN deleted d ON d.device_id = i.device_id
WHERE ISNULL(d.firmware_version,'') <> ISNULL(i.firmware_version,'')
OR ISNULL(d.device_status,'') <> ISNULL(i.device_status,'');
END
GO

--Check the Audit Table using example
--Update the Devices table to trigger Audit table
 UPDATE dbo.Devices
SET firmware_version = 'v3.1.0'
WHERE device_id = 'DEV001';

--Check the Audit Table
SELECT * 
FROM dbo.DeviceAudit 
WHERE device_id = 'DEV001';

--8. CREATE INDEXED VIEWS
--Check if already exists or not
IF OBJECT_ID ('MonthlySales','V') IS NOT NULL
DROP VIEW MonthlySales;
 
--Create New View
CREATE VIEW SalesSummary
WITH SCHEMABINDING
AS
SELECT 
     YEAR(s.sale_date) AS sale_year,
     MONTH(s.sale_date) AS sale_month,
     s.product_name,
     s.product_category,
     SUM(s.total_amount) AS TotalSales,
     COUNT_BIG (*) AS row_count
FROM dbo.Sales s
GROUP BY YEAR(s.sale_date), MONTH(s.sale_date), s.product_name, s.product_category;
GO

--Create Clustered Index on the View
CREATE UNIQUE CLUSTERED INDEX UXI_SalesSummary
ON SalesSummary (sale_year, sale_month, product_name, product_category);
GO

--Use View in some real_world examples to have faster access to table information
--Question1: Query the results based on specific year and month?
SELECT *
FROM SalesSummary
WHERE sale_year = '2021' AND sale_month = '08';

--Question2: Show the top 10 Customers who spends more in the last 6 months?
SELECT TOP 10 
     s.user_id,
     SUM(s.total_amount) AS TotalSpend
FROM dbo.Sales s
WHERE s.sale_date >= DATEADD (YEAR, -5, CAST(GETDATE() AS date))
GROUP BY s.user_id
ORDER BY TotalSpend DESC;

