-- ========================================
-- Organization Table
-- ========================================
CREATE TABLE organization (
    organization_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    logo_filename VARCHAR(255) NOT NULL
);

-- ========================================
-- Insert sample data: Organizations
-- ========================================
INSERT INTO organization (name, description, contact_email, logo_filename)
VALUES
('BrightFuture Builders', 'A nonprofit focused on improving community infrastructure through sustainable construction projects.', 'info@brightfuturebuilders.org', 'brightfuture-logo.png'),
('GreenHarvest Growers', 'An urban farming collective promoting food sustainability and education in local neighborhoods.', 'contact@greenharvest.org', 'greenharvest-logo.png'),
('UnityServe Volunteers', 'A volunteer coordination group supporting local charities and service initiatives.', 'hello@unityserve.org', 'unityserve-logo.png');

-- ========================================
-- Service Projects Table
-- ========================================
CREATE TABLE service_project (
	project_id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL,
    title VARCHAR(50) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(50) NOT NULL,
    date DATE NOT NULL,
	CONSTRAINT fl_organization
		FOREIGN KEY (organization_id)
		REFERENCES organization(organization_id)
		ON DELETE CASCADE
);


-- ========================================
-- Insert sample data: Service Projects
-- ========================================
INSERT INTO service_project (organization_id, title, description, location, date)
VALUES
(1, 'Beach Cleanup', 'A gathering of the community to clean the beach.', 'the beach', '2024-06-15'),
(1, 'Park Beautification', 'A group of people beautifying the park.', 'the park', '2024-07-20'),
(1, 'Food Drive', 'A food drive to help those in need.', 'community center', '2026-08-10'),
(1, 'Tree Planting', 'A tree planting event to help the environment.', 'local park', '2026-09-05'),
(1, 'Community Cleanup', 'A community effort to clean up the neighborhood.', 'community center', '2026-02-12'),
(2, 'Community Painting', 'A gathering of many people to paint the community center.', 'community center', '2024-06-15'),
(2, 'House Cleaning', 'A cleaning the houses of the elderly in the community.', 'community center', '2024-07-20'),
(2, 'Car Maintenance', 'An activity to clean and fix people''s cars.', 'community center', '2026-08-10'),
(2, 'Community Gardening', 'A community gardening event to help the environment.', 'local park', '2026-09-05'),
(2, 'Community Recycling', 'A community effort to recycle and clean up the neighborhood.', 'community center', '2026-02-12'),
(3, 'Group Painting', 'A gathering of many people to paint the community center.', 'community center', '2024-06-15'),
(3, 'House Cleaning', 'A cleaning the houses of the elderly in the community.', 'community center', '2024-07-20'),
(3, 'Car Maintenance', 'An activity to clean and fix people''s cars.', 'community center', '2026-08-10'),
(3, 'Community Gardening', 'A community gardening event to help the environment.', 'local park', '2026-09-05'),
(3, 'Reading Program', 'A community effort to read and help the neighborhood.', 'community center', '2026-02-12');


-- ========================================
-- Create Category Table
-- ========================================
CREATE TABLE category (
	category_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);		

-- ========================================
-- Insert sample data: Categories   
-- ========================================
INSERT INTO category (name)
VALUES
('Cleanup'),
('Environmental'),
('Food Donation'),
('Community'),
('Education');


-- ========================================
-- Create Table for Many-to-Many Relationship between Service Projects and Categories
-- ========================================
CREATE TABLE service_project_category (
    service_project_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    PRIMARY KEY (service_project_id, category_id),
    CONSTRAINT fk_project
    FOREIGN KEY (service_project_id) 
    REFERENCES service_project(project_id) 
    ON DELETE CASCADE,
    CONSTRAINT fk_category
    FOREIGN KEY (category_id)
    REFERENCES category(category_id) 
    ON DELETE CASCADE
);

-- ========================================
-- Link Service Projects to Categories
-- ========================================
INSERT INTO service_project_category (service_project_id, category_id)
VALUES
(1, 1), -- Beach Cleanup -> Cleanup
(1, 4), -- Beach Cleanup -> Community
(2, 1), -- Park Beautification -> Cleanup
(2, 2), -- Park Beautification -> Environmental
(2, 4), -- Park Beautification -> Community
(3, 3), -- Food Drive -> Food Donation
(3, 4), -- Food Drive -> Community
(4, 2), -- Tree Planting -> Environmental
(5, 1), -- Community Cleanup -> Cleanup
(5, 4), -- Community Cleanup -> Community
(6, 4), -- Community Painting -> Community
(7, 1), -- House Cleaning -> Cleanup
(7, 4), -- House Cleaning -> Community
(8, 4), -- Car Maintenance -> Community
(9, 2), -- Community Gardening -> Environmental
(9, 4), -- Community Gardening -> Community
(10, 1), -- Community Recycling -> Cleanup
(10, 2), -- Community Recycling -> Environmental
(10, 4), -- Community Recycling -> Community
(11, 4), -- Group Painting -> Community
(12, 1), -- House Cleaning -> Cleanup
(12, 4), -- House Cleaning -> Community
(13, 4), -- Car Maintenance -> Community
(14, 2), -- Community Gardening -> Environmental
(14, 4), -- Community Gardening -> Community
(15, 4), -- Reading Program -> Community
(15, 5); -- Reading Program -> Education