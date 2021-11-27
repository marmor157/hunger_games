import React, { lazy } from "react";

import { RouteObject } from "react-router";
import paths from "./paths";

const WelcomeScreen = lazy(() => import("../pages/WelcomeScreen"));
const NewSchedule = lazy(() => import("../pages/NewSchedule"));
const EditSchedule = lazy(() => import("../pages/EditSchedule/EditSchedule"));

const routes: RouteObject[] = [
  { path: "*", element: <div>404</div> },
  { path: paths.root, element: <WelcomeScreen /> },
  { path: paths.schedule.new, element: <NewSchedule /> },
  { path: paths.schedule.edit(":id"), element: <EditSchedule /> },
];

export default routes;
