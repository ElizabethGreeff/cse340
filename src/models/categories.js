import db from './db.js';

const getAllCategories = async () => {
  const query = `
      SELECT category_id, name
      FROM public.category
      ORDER BY name
  `;

  const result = await db.query(query);
  return result.rows;
};

const getCategoryById = async (category_id) => {
  const query = `
      SELECT category_id, name
      FROM public.category
      WHERE category_id = $1
  `;

  const result = await db.query(query, [category_id]);
  return result.rows[0];
};

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
};

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
};

const createCategory = async (name) => {
  const query = `
      INSERT INTO category (name)
      VALUES ($1)
      RETURNING category_id
  `;

  const result = await db.query(query, [name]);

  if (result.rows.length === 0) {
    throw new Error('Failed to create category');
  }

  if (process.env.ENABLE_SQL_LOGGING === 'true') {
    console.log('Created new category with ID:', result.rows[0].category_id);
  }

  return result.rows[0].category_id;
};

const updateCategory = async (categoryId, name) => {
  const query = `
      UPDATE category
      SET name = $1
      WHERE category_id = $2
      RETURNING category_id
  `;

  const result = await db.query(query, [name, categoryId]);

  if (result.rows.length === 0) {
    throw new Error('Category not found');
  }

  if (process.env.ENABLE_SQL_LOGGING === 'true') {
    console.log('Updated category with ID:', categoryId);
  }

  return result.rows[0].category_id;
};

export { getAllCategories, getCategoryById, getCategoriesByProjectId, getProjectsByCategoryId, createCategory, updateCategory };