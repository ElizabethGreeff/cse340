import db from './db.js'

const getAllProjects = async () => {
    const query = `
        SELECT project_id, service_project.organization_id, title, service_project.description, location, date,
        organization.name AS organization_name
      FROM public.service_project
      JOIN organization ON service_project.organization_id = organization.organization_id
      ORDER BY date
    `;

    const result = await db.query(query);

    return result.rows;
}

const getProjectsByOrganizationId = async (organizationId) => {
  const query = `
        SELECT
          project_id,
          organization_id,
          title,
          description,
          location,
          date
        FROM service_project
        WHERE organization_id = $1
        ORDER BY date;
      `;

  const queryParams = [organizationId];
  const result = await db.query(query, queryParams);

  return result.rows;
};

const getUpcomingProjects = async (number_of_projects) => {
  const query = `
      SELECT project_id,
      service_project.organization_id,
      title,
      service_project.description,
      location,
      date,
      organization.name AS organization_name
      FROM public.service_project
      JOIN organization ON service_project.organization_id = organization.organization_id
      ORDER BY date
      LIMIT $1;
    `;

  const queryParams = [number_of_projects];
  const result = await db.query(query, queryParams);

  return result.rows;
};

const getProjectDetails = async (id) => {
  const query = `
      SELECT project_id,
      service_project.organization_id,
      title,
      service_project.description,
      location,
      date,
      organization.name AS organization_name
      FROM public.service_project
      JOIN organization
      ON service_project.organization_id = organization.organization_id
      WHERE project_id = $1;
    `;

  const queryParams = [id];
  const result = await db.query(query, queryParams);

  return result.rows[0];
};

const createProject = async (title, description, location, date, organizationId) => {
  const query = `
      INSERT INTO service_project (title, description, location, date, organization_id)
      VALUES ($1, $2, $3, $4, $5)
      RETURNING project_id;
    `;

  const queryParams = [title, description, location, date, organizationId];
  const result = await db.query(query, queryParams);

  if (result.rows.length === 0) {
    throw new Error('Failed to create project');
  }

  if (process.env.ENABLE_SQL_LOGGING === 'true') {
    console.log('Created new project with ID:', result.rows[0].project_id);
  }

  return result.rows[0].project_id;
}

export { getAllProjects, getProjectsByOrganizationId, getUpcomingProjects, getProjectDetails, createProject };