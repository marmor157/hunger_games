import { Center, Container, HStack } from "@chakra-ui/react";
import {
  CreateClassInput,
  useClassCreateMutation,
  useGetScheduleQuery,
} from "../../graphql";

import Calendar from "../components/Calendar";
import React from "react";
import ScheduleForm from "./ScheduleForm";
import { Spinner } from "@chakra-ui/spinner";
import { useParams } from "react-router";

const EditSchedule: React.FC = () => {
  const { id } = useParams();

  const { data, refetch } = useGetScheduleQuery({
    variables: { id: id ?? "" },
  });
  const [createClass] = useClassCreateMutation();
  // const [deleteClass] = useClassDeleteMutation();

  if (!data?.schedule || !id)
    return (
      <Center>
        <Spinner />
      </Center>
    );

  const onCreateClass = async (data: CreateClassInput) => {
    const response = await createClass({ variables: { input: data } });
    if (response.data?.classCreate) refetch();
  };

  const { startDate, endDate, classes } = data.schedule;

  return (
    <Container maxW="container.2xl">
      <HStack spacing={4} align="stretch">
        <Calendar
          classes={classes}
          startDate={new Date(startDate)}
          endDate={new Date(endDate)}
        />
        <ScheduleForm {...data.schedule} onCreateClass={onCreateClass} />
      </HStack>
    </Container>
  );
};

export default EditSchedule;
