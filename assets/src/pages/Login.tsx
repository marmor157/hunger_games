import * as yup from "yup";

import { Container, VStack } from "@chakra-ui/layout";

import { AUTH_TOKEN } from "../consts";
import { Button } from "@chakra-ui/button";
import FormControlInput from "../components/FormControlInput";
import React from "react";
import { useForm } from "react-hook-form";
import { useLoginMutation } from "../graphql";
import { yupResolver } from "@hookform/resolvers/yup";

interface LoginForm {
  email: string;
  password: string;
}

const schema = yup.object({
  email: yup.string().required().email(),
  password: yup.string().required(),
});

const Login: React.FC = () => {
  const { control, handleSubmit, setError } = useForm<LoginForm>({
    resolver: yupResolver(schema),
  });
  const [login] = useLoginMutation({ refetchQueries: ["me"] });

  const onSubmit = async (data: LoginForm) => {
    const response = await login({ variables: data });
    if (response.data)
      localStorage.setItem(AUTH_TOKEN, response.data.login.token);
    else setError("email", { message: response.errors?.[0].message });
  };

  return (
    <Container>
      <form onSubmit={handleSubmit(onSubmit)}>
        <VStack>
          <FormControlInput name="email" control={control} label="Email" />
          <FormControlInput
            name="password"
            control={control}
            label="Password"
            type="password"
          />
          <Button type="submit">Login</Button>
        </VStack>
      </form>
    </Container>
  );
};

export default Login;
