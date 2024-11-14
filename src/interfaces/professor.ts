// Tipo para representar un Profesor
export interface Professor {
  id?: number;
  first_name: string;
  department: string;
  last_name: string;
  email: string;
  phone?: string;
}

export interface PaginatedProfessor {
  page: number;
  limit: number;
  total: number;
  totalPages: number;
  data: Professor[];
}
