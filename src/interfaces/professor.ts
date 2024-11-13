// Tipo para representar un Profesor
export interface Professor {
  id?: number;
  first_name: string;
  last_name: string;
  date_of_birth: string;
  email: string;
  address?: string;
  phone?: string;
  gender: "M" | "F" | "Otro";
  grade_level: string;
}

export interface PaginatedProfessor {
  page: number;
  limit: number;
  total: number;
  totalPages: number;
  data: Professor[];
}
