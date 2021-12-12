import { ClassType } from "../graphql";

export const classTypeToShortcut: Record<ClassType, string> = {
  [ClassType.ComputerLaboratories]: "Laboratoria Komputerowe",
  [ClassType.Exercises]: "Ćwiczenia",
  [ClassType.Laboratories]: "Laboratoria",
  [ClassType.Lecture]: "Wykład",
  [ClassType.Project]: "Projekt",
};

export default classTypeToShortcut;
