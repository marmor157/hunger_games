import * as yup from "yup";

import { HStack, VStack } from "@chakra-ui/layout";

import { AUTH_TOKEN } from "../../consts";
import { Button } from "@chakra-ui/button";
import FormControlInput from "../../components/FormControlInput";
import React from "react";
import { useForm } from "react-hook-form";
import { useLoginMutation } from "../../graphql";
import { yupResolver } from "@hookform/resolvers/yup";

interface LoginProps {
  onRegister: () => void;
}

interface LoginForm {
  email: string;
  password: string;
}

const schema = yup.object({
  email: yup.string().required("Pole wymagane").email(),
  password: yup.string().required("Pole wymagane"),
});

const Login: React.FC<LoginProps> = ({ onRegister }) => {
  const { control, handleSubmit, setError } = useForm<LoginForm>({
    resolver: yupResolver(schema),
  });
  const [login, { client }] = useLoginMutation();

  const onSubmit = async (data: LoginForm) => {
    const response = await login({ variables: data });
    if (response.data) {
      await localStorage.setItem(AUTH_TOKEN, response.data.login.token);
      client.refetchQueries({ include: ["me"] });
    } else setError("email", { message: response.errors?.[0].message });
  };

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <VStack>
        <FormControlInput name="email" control={control} label="Email" />
        <FormControlInput
          name="password"
          control={control}
          label="Hasło"
          type="password"
        />
        <HStack justify="stretch" spacing={2}>
          <Button onClick={onRegister}>Nie mam konta</Button>
          <Button type="submit">Login</Button>
        </HStack>
      </VStack>
    </form>
  );
};

export default Login;
