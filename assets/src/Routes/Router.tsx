import React, { Suspense } from "react";

import { Spinner } from "@chakra-ui/react";
import routes from "./routes";
import { useRoutes } from "react-router-dom";

const Router: React.FC = () => {
  const pages = useRoutes(routes);

  return <Suspense fallback={<Spinner />}>{pages}</Suspense>;
};

export default Router;
