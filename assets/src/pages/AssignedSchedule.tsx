import { Center, Container, HStack, Text, VStack } from "@chakra-ui/layout";

import Calendar from "./components/Calendar";
import React from "react";
import { useGetAssignedScheduleByStudentScheduleQuery } from "../graphql";
import { useParams } from "react-router";

const AssignedSchedule: React.FC = () => {
  const { studentId = "", scheduleId = "" } = useParams();

  const { data } = useGetAssignedScheduleByStudentScheduleQuery({
    variables: { studentId, scheduleId },
  });

  if (!data?.assignedScheduleByStudentSchedule)
    return <Center>Nie ma jeszcze takiego planu</Center>;

  const {
    classes,
    schedule: { startDate, endDate, name },
  } = data.assignedScheduleByStudentSchedule;

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
