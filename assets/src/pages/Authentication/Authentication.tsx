import React, { useState } from "react";

import { Container } from "@chakra-ui/layout";
import Login from "./Login";
import Register from "./Register";
import RoundedCenter from "../components/RoundedCenter";

const Authentication: React.FC = () => {
  const [isLogin, setIsLogin] = useState(true);

  return (
    <Container>
      <RoundedCenter>
        {isLogin ? (
          <Login onRegister={() => setIsLogin(false)} />
        ) : (
          <Register onLogin={() => setIsLogin(true)} />
        )}
      </RoundedCenter>
    </Container>
  );
};

export default Authentication;
