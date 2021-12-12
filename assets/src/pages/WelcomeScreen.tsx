import { Divider, Flex, VStack } from "@chakra-ui/layout";

import { AUTH_TOKEN } from "../consts";
import { Button } from "@chakra-ui/button";
import FormControlInput from "../components/FormControlInput";
import { Link } from "react-router-dom";
import React from "react";
import RoundedCenter from "./components/RoundedCenter";
import paths from "../Routes/paths";
import { useApolloClient } from "@apollo/client";
import { useForm } from "react-hook-form";

interface FormData {
  id: string;
}

const WelcomeScreen: React.FC = () => {
  const { control, handleSubmit } = useForm<FormData>();
  const client = useApolloClient();

  const onSubmit = (data: FormData) => {
    console.log(data);
  };

  return (
    <Flex height="100vh" justify="center">
      <RoundedCenter>
        <VStack align="stretch" spacing={4}>
          <Button>
            <Link to={paths.schedule.new}>Create new schedule</Link>
          </Button>
          <Divider />
          <form onSubmit={handleSubmit(onSubmit)}>
            <VStack align="stretch" spacing={4}>
              <FormControlInput
                control={control}
                name="id"
                label="Existing Schedule ID"
              />

              <Button type="submit">Open Existing Schedule</Button>
            </VStack>
          </form>
          <Divider />
          <Button
            onClick={() => {
              localStorage.setItem(AUTH_TOKEN, "");
              client.resetStore();
            }}
          >
            Log out
          </Button>
        </VStack>
      </RoundedCenter>
    </Flex>
  );
};

export default WelcomeScreen;
