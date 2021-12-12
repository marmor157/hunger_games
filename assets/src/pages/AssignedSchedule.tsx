import { Center, Container, HStack, Text, VStack } from "@chakra-ui/layout";

import Calendar from "./components/Calendar";
import React from "react";
import { useGetAssignedScheduleByStudentScheduleQuery } from "../graphql";
import { useParams } from "react-router";

const AssignedSchedule: React.FC = () => {
  const { scheduleId = "" } = useParams();

  const { data } = useGetAssignedScheduleByStudentScheduleQuery({
    variables: { scheduleId },
  });

  if (!data?.assignedScheduleByScheduleId)
    return <Center>Nie ma jeszcze takiego planu</Center>;

  const {
    classes,
    schedule: { startDate, endDate, name },
  } = data.assignedScheduleByScheduleId;

  return (
    <Container maxW="container.2xl">
      <VStack>
        <HStack>
          <Text>{name}</Text>
          <Text>
            {new Date(startDate).toLocaleDateString()} -{" "}
            {new Date(endDate).toLocaleDateString()}
          </Text>
        </HStack>
        <Calendar
          classes={classes}
          startDate={new Date(startDate)}
          endDate={new Date(endDate)}
        />
      </VStack>
    </Container>
  );
};

export default AssignedSchedule;
