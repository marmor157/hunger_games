export type PathFunction = (...args: string[]) => string;
export type Path = string | PathFunction;
interface Paths {
  [prop: string]: Path | Record<string, Paths | Path>;
}

const pathsDict = {
  root: "/",
  schedule: {
    new: "/new",
    details: (id: string) => `/${id}`,
    edit: (id: string) => `/${id}/edit`,
    request: (id: string) => `/${id}/request`,
  },
  assignedSchedule: {
    details: (scheduleId: string, studentId: string) =>
      `/${scheduleId}/${studentId}/details`,
  },
  lecturer: {
    new: "/new",
  },
};

function applyRoutes(routes: Paths, basePath: string = ""): Paths {
  const entries = Object.entries(routes).map(([key, value]) => {
    if (typeof value === "string") return [key, `${basePath}${value}`];

    if (typeof value === "function")
      return [key, (...args: string[]) => `${basePath}${value(...args)}`];

    if (typeof value === "object")
      return [key, applyRoutes(value, `${basePath}/${key}`)];

    // That shouldn't be called at all
    console.warn("Incorrect routes");
    return [key, ""];
  });
  return Object.fromEntries(entries);
}

// Overriding `Routes` typing so IDE can autosuggest what routes we have
export const paths = applyRoutes(pathsDict) as unknown as typeof pathsDict;

export default paths;
