import { Box, Center, Divider, Flex, VStack } from "@chakra-ui/layout";

import { Button } from "@chakra-ui/button";
import FormControlInput from "../components/FormControlInput";
import { Link } from "react-router-dom";
import React from "react";
import paths from "../Routes/paths";
import { useForm } from "react-hook-form";

interface FormData {
  id: string;
}

const WelcomeScreen: React.FC = () => {
  const { control, handleSubmit } = useForm<FormData>();

  const onSubmit = (data: FormData) => {
    console.log(data);
  };

  return (
    <Flex height="100vh" justify="center">
      <Center>
        <Box bg="gray.700" p={4} borderRadius="lg">
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
          </VStack>
        </Box>
      </Center>
    </Flex>
  );
};

export default WelcomeScreen;
