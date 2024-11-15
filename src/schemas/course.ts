import { z } from "zod";

export const courseSchema = z.object({
  course_name: z
    .string()
    .min(2, { message: "El nombre debe tener al menos 2 caracteres" }),
  credits: z
    .string()
    .min(1, { message: "Los creditos debe tener al menos 1 caracter" }),
  description: z
    .string()
    .min(2, { message: "La descripcion debe tener al menos 2 caracteres" }),
  teacher_id: z
    .string()
    .min(1, { message: "El teacher_id debe tener al menos 1 caracteres" }),
});
