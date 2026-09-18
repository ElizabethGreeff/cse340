// Import any needed model functions
import { getAllProjects, getUpcomingProjects, getProjectDetails } from '../models/projects.js';
import { getCategoriesByProjectId } from '../models/categories.js';

const NUMBER_OF_UPCOMING_PROJECTS = 5;

// Define any controller functions
const showProjectsPage = async (req, res) => {
    const projects = await getUpcomingProjects(NUMBER_OF_UPCOMING_PROJECTS); // Fetch the next 5 upcoming projects
    const title = 'Upcoming Service Projects';

    res.render('projects', { title, projects });
};

const showProjectDetailsPage = async (req, res) => {
    const projectId = req.params.id;
    const projectDetails = await getProjectDetails(projectId);
    const title = 'Project Details';

    const categories = await getCategoriesByProjectId(projectId);

    res.render('project', { title, project: projectDetails , categories });
};



// Export any controller functions
export { showProjectsPage, showProjectDetailsPage };