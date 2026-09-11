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

