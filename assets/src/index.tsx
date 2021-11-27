import React, { useEffect } from "react";

import Router from "./Routes/Router";
import { useColorMode } from "@chakra-ui/color-mode";

const Index: React.FC = () => {
  const { setColorMode } = useColorMode();

  useEffect(() => {
    setColorMode("dark");
  }, [setColorMode]);

  return <Router />;
};

export default Index;
