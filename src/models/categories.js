import db from './db.js'

const getAllCategories = async () => {
    const query = `
        SELECT category_id, name
      FROM public.category
      ORDER BY name
    `;

    const result = await db.query(query);

    return result.rows;
}

const getCategoryById = async (category_id) => {
    const query = `
        SELECT category_id, name
        FROM public.category
        WHERE category_id = $1
    `;

    const result = await db.query(query, [category_id]);

    return result.rows[0];
}

const getCategoriesByProjectId = async (project_id) => {
  const query = `
      SELECT c.category_id, c.name
      FROM category c
      JOIN service_project_category spc ON c.category_id = spc.category_id
      WHERE spc.service_project_id = $1
      ORDER BY c.name
  `;

  const result = await db.query(query, [project_id]);

  return result.rows;
}

const getProjectsByCategoryId = async (category_id) => {
  const query = `
      SELECT sp.project_id, sp.title
      FROM service_project sp
      JOIN service_project_category spc ON sp.project_id = spc.service_project_id
      WHERE spc.category_id = $1
      ORDER BY sp.title
    `;
  
  const result = await db.query(query, [category_id]);
  return result.rows;
}


export { getAllCategories, getCategoryById, getCategoriesByProjectId, getProjectsByCategoryId };