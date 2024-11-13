import pool from "../db";
import { ResultSetHeader, RowDataPacket } from "mysql2/promise";
import { PaginatedProfessor, Professor } from "../interfaces/professor";

// Obtener todos los alumnos
export const findAllProfessors = async (
  limit: number,
  offset: number,
): Promise<PaginatedProfessor> => {
  const [rows] = await pool.query<RowDataPacket[]>(
    "SELECT * FROM professors LIMIT ? OFFSET ?",
    [limit, offset],
  );
  // Consulta para obtener el total de registros
  const [totalRows] = (await pool.query(
    "SELECT COUNT(*) as count FROM professors",
  )) as [{ count: number }[], unknown];
  const total = totalRows[0].count;

  // Calcular el total de páginas
  const totalPages = Math.ceil(total / limit);

  return {
    page: offset / limit + 1,
    limit,
    total,
    totalPages,
    data: rows as Professor[],
  };
};

export const insertProfessor = async (
  professor: Professor,
): Promise<Professor> => {
  const {
    first_name,
    last_name,
    date_of_birth,
    email,
    address,
    phone,
    gender,
    grade_level,
  } = professor;
  const [result] = await pool.query<ResultSetHeader>(
    `INSERT INTO professor (first_name, last_name, date_of_birth, email, address, phone, gender, grade_level) 
     VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
    [
      first_name,
      last_name,
      date_of_birth,
      email,
      address,
      phone,
      gender,
      grade_level,
    ],
  );
  const { insertId } = result;
  return { id: insertId, ...professor };
};

export const updateProfessor = async (
  id: number,
  professor: Professor,
): Promise<Professor> => {
  const {
    first_name,
    last_name,
    date_of_birth,
    email,
    address,
    phone,
    gender,
    grade_level,
  } = professor;
  await pool.query<ResultSetHeader>(
    `UPDATE professors
     SET first_name = ?, 
         last_name = ?, 
         date_of_birth = ?, 
         email = ?, 
         address = ?, 
         phone = ?, 
         gender = ?, 
         grade_level = ?
     WHERE id = ?;`,
    [
      first_name,
      last_name,
      date_of_birth,
      email,
      address,
      phone,
      gender,
      grade_level,
      id,
    ],
  );

  return { id, ...professor };
};

export const deleteProfessor = async (id: number): Promise<number> => {
  await pool.query<ResultSetHeader>("DELETE FROM professors WHERE id = ?", [
    id,
  ]);

  return id;
};
