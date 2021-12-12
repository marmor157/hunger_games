import {
  Center,
  Container,
  Divider,
  Flex,
  HStack,
  Text,
  VStack,
} from "@chakra-ui/layout";
import { Link, useNavigate } from "react-router-dom";
import {
  useListMyAssignedSchedulesQuery,
  useListMySchedulesQuery,
} from "../graphql";

import { AUTH_TOKEN } from "../consts";
import { Button } from "@chakra-ui/button";
import FormControlInput from "../components/FormControlInput";
import React from "react";
import RoundedCenter from "./components/RoundedCenter";
import paths from "../Routes/paths";
import { useApolloClient } from "@apollo/client";
import { useForm } from "react-hook-form";

interface FormData {
  id: string;
}

const WelcomeScreen: React.FC = () => {
  const navigate = useNavigate();
  const { control, handleSubmit } = useForm<FormData>();
  const client = useApolloClient();
  const { data: myAssignedSchedulesData } = useListMyAssignedSchedulesQuery();
  const { data: mySchedulesData } = useListMySchedulesQuery();

  const onSubmit = (data: FormData) => {
    navigate(paths.schedule.request(data.id));
  };

  return (
    <Container maxW="container.xl">
      <Center>
        <HStack>
          <Flex height="100vh" justify="center">
            <RoundedCenter>
              <VStack align="stretch" spacing={4}>
                <Button>
                  <Link to={paths.schedule.new}>Stwórz nowy plan</Link>
                </Button>
                <Divider />
                <form onSubmit={handleSubmit(onSubmit)}>
                  <VStack align="stretch" spacing={4}>
                    <FormControlInput
                      control={control}
                      name="id"
                      label="ID istniejącego planu"
                    />

                    <Button type="submit">Zapisz się do planu</Button>
                  </VStack>
                </form>
                <Divider />
                <Button
                  onClick={() => {
                    localStorage.setItem(AUTH_TOKEN, "");
                    client.resetStore();
                  }}
                >
                  Wyloguj
                </Button>
              </VStack>
            </RoundedCenter>
          </Flex>
          <VStack alignItems="stretch">
            <Text align="center">Przypisane plany:</Text>
            {myAssignedSchedulesData?.listAssignedSchedules.map(
              (assignedSchedule) => (
                <Button
                  key={assignedSchedule.id}
                  onClick={() =>
                    navigate(
                      paths.assignedSchedule.details(
                        assignedSchedule.schedule.id,
                        assignedSchedule.student.id
                      )
                    )
                  }
                >
                  <HStack>
                    <Text>{assignedSchedule.schedule.name}</Text>
                    <Text>
                      {new Date(
                        assignedSchedule.schedule.startDate
                      ).toLocaleDateString()}
                    </Text>
                    <Text>-</Text>
                    <Text>
                      {new Date(
                        assignedSchedule.schedule.endDate
                      ).toLocaleDateString()}
                    </Text>
                  </HStack>
                </Button>
              )
            )}
            <Text align="center">Stworzone przeze mnie: </Text>
            {mySchedulesData?.listSchedules.map((schedule) => (
              <Button
                key={schedule.id}
                onClick={() => navigate(paths.schedule.edit(schedule.id))}
              >
                <HStack>
                  <Text>{schedule.name}</Text>
                  <Text>
                    {new Date(schedule.startDate).toLocaleDateString()}
                  </Text>
                  <Text>-</Text>
                  <Text>{new Date(schedule.endDate).toLocaleDateString()}</Text>
                </HStack>
              </Button>
            ))}
          </VStack>
        </HStack>
      </Center>
    </Container>
  );
};

export default WelcomeScreen;
