// Tipo para representar un Profesor
export interface Course {
  id?: number;
  course_name: string;
  credits: string;
  description: string;
  teacher_id: string;
}

export interface PaginatedCourse {
  page: number;
  limit: number;
  total: number;
  totalPages: number;
  data: Course[];
}
