import React, { useEffect } from "react";

import Login from "./pages/Login";
import Router from "./Routes/Router";
import { useColorMode } from "@chakra-ui/color-mode";
import { useMeQuery } from "./graphql";
import { useUserContext } from "./contexts/userContext";

const Index: React.FC = () => {
  const { setColorMode } = useColorMode();
  const [state, dispatch] = useUserContext();
  const { data } = useMeQuery();

  useEffect(() => {
    dispatch({ type: "SET_USER", payload: data?.me ?? undefined });
  }, [data, dispatch]);

  useEffect(() => {
    setColorMode("dark");
  }, [setColorMode]);
  if (!state.user) return <Login />;

  return <Router />;
};

export default Index;
