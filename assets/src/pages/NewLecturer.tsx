import * as yup from "yup";

import { Button, Container, Text, VStack } from "@chakra-ui/react";
import { CreateLecturerInput, useCreateLecturerMutation } from "../graphql";
import React, { useEffect } from "react";
import { useLocation, useNavigate } from "react-router";

import FormControlInput from "../components/FormControlInput";
import { useForm } from "react-hook-form";
import { yupResolver } from "@hookform/resolvers/yup";

const schema = yup.object({
  name: yup.string().required(),
});

const NewLecturer: React.FC = () => {
  const location = useLocation();
  const navigate = useNavigate();
  const { control, handleSubmit } = useForm<CreateLecturerInput>({
    resolver: yupResolver(schema),
  });
  const [createLecturer, { data, loading, error }] = useCreateLecturerMutation({
    refetchQueries: ["listLecturers"],
  });

  const onSubmit = (data: CreateLecturerInput) => {
    createLecturer({
      variables: {
        input: data,
      },
    });
  };

  useEffect(() => {
    if (data?.lecturerCreate) {
      if (location.state.pathname)
        navigate(location.state.pathname, { state: location.state });
      else navigate(-1);
    }
  }, [data, location.state, navigate]);

  return (
    <Container>
      <form onSubmit={handleSubmit(onSubmit)}>
        <VStack align="stretch" spacing={4}>
          <Text fontSize="2xl">Dodaj nowego wykładowce</Text>
          <FormControlInput
            control={control}
            name="name"
            label="Name"
            placeholder="Nazwa"
          />
          {error && (
            <Text fontSize="2xl" colorScheme="red">
              {error.message}
            </Text>
          )}
          <Button type="submit" alignSelf="flex-end" isLoading={loading}>
            Utwórz
          </Button>
        </VStack>
      </form>
    </Container>
  );
};

export default NewLecturer;
