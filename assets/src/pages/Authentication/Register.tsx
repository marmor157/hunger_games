import * as yup from "yup";

import { Text, VStack } from "@chakra-ui/layout";

import { Button } from "@chakra-ui/button";
import FormControlInput from "../../components/FormControlInput";
import { HStack } from "@chakra-ui/react";
import React from "react";
import { useForm } from "react-hook-form";
import { useRegisterMutation } from "../../graphql";
import { yupResolver } from "@hookform/resolvers/yup";

interface RegisterProps {
  onLogin: () => void;
}

interface RegisterForm {
  email: string;
  name: string;
  password: string;
  confirmPassword: string;
}

const errorMessage = (errorMessage: string): string => {
  switch (errorMessage) {
    case "email_taken":
      return "Email zajęty";
    default:
      return errorMessage;
  }
};

const schema = yup.object({
  email: yup.string().required("Pole wymagane").email(),
  name: yup.string().required("Pole wymagane"),
  password: yup
    .string()
    .required("Pole wymagane")
    .oneOf([yup.ref("confirmPassword")], "Hasła nie są takie same"),
  confirmPassword: yup
    .string()
    .required("Pole wymagane")
    .oneOf([yup.ref("password")], "Hasła nie są takie same"),
});

const Register: React.FC<RegisterProps> = ({ onLogin }) => {
  const { control, handleSubmit } = useForm<RegisterForm>({
    resolver: yupResolver(schema),
  });
  const [register, { data, error, loading }] = useRegisterMutation();

  const onSubmit = async ({ confirmPassword: _, ...data }: RegisterForm) => {
    register({ variables: { input: data } });
  };

  if (data?.register.id)
    return (
      <VStack>
        <Text>Zarejestrowano</Text>
        <Button onClick={onLogin}>Zaloguj</Button>
      </VStack>
    );

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <VStack>
        {error && <Text color="red">{errorMessage(error.message)}</Text>}
        <FormControlInput
          name="email"
          control={control}
          label="Email"
          type="email"
        />
        <FormControlInput
          name="name"
          control={control}
          label="Imię i Naziwsko"
        />
        <FormControlInput
          name="password"
          control={control}
          label="Hasło"
          type="password"
        />
        <FormControlInput
          name="confirmPassword"
          control={control}
          label="Powtórz hasło"
          type="password"
        />
        <HStack>
          <Button onClick={onLogin}>Mam konto</Button>
          <Button type="submit" disabled={loading}>
            Zarejestruj
          </Button>
        </HStack>
      </VStack>
    </form>
  );
};

export default Register;
