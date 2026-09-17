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

export { getAllProjects }  