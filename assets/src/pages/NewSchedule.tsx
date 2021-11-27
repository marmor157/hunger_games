import * as yup from "yup";

import { Button, Container, Text, VStack } from "@chakra-ui/react";
import { CreateScheduleInput, useCreateScheduleMutation } from "../graphql";
import React, { useEffect } from "react";

import FormControlInput from "../components/FormControlInput";
import datetimeToDate from "../utils/datetimeToDate";
import paths from "../Routes/paths";
import { useForm } from "react-hook-form";
import { useNavigate } from "react-router";
import { yupResolver } from "@hookform/resolvers/yup";

const schema = yup.object({
  name: yup.string().required(),
  registrationStartDate: yup.date().required(),
  registrationEndDate: yup.date().required(),
  startDate: yup.date().required(),
  endDate: yup.date().required(),
});

const today = new Date().toISOString().substring(0, 16);

const NewSchedule: React.FC = () => {
  const navigate = useNavigate();
  const { control, handleSubmit, watch } = useForm<CreateScheduleInput>({
    resolver: yupResolver(schema),
  });
  const [createSchedule, { data, loading, error }] =
    useCreateScheduleMutation();

  const onSubmit = ({ startDate, endDate, ...data }: CreateScheduleInput) => {
    createSchedule({
      variables: {
        input: {
          ...data,
          startDate: datetimeToDate(startDate),
          endDate: datetimeToDate(endDate),
        },
      },
    });
  };

  useEffect(() => {
    if (data && data.scheduleCreate.id)
      navigate(paths.schedule.edit(data.scheduleCreate.id));
  }, [data, navigate]);

  const startDate = watch("startDate") ?? today;

  return (
    <Container>
      <form onSubmit={handleSubmit(onSubmit)}>
        <VStack align="stretch" spacing={4}>
          <Text fontSize="2xl">Create new schedule</Text>
          <FormControlInput
            control={control}
            name="name"
            label="Name"
            placeholder="Name"
          />
          <FormControlInput
            control={control}
            name="startDate"
            label="Start Date"
            type="date"
            min="today"
          />
          <FormControlInput
            control={control}
            name="endDate"
            label="End Date"
            type="date"
            min={startDate}
          />
          <FormControlInput
            control={control}
            name="registrationStartDate"
            label="Registration Start Date"
            type="datetime-local"
            max={startDate}
          />
          <FormControlInput
            control={control}
            name="registrationEndDate"
            label="Registration End Date"
            type="datetime-local"
            max={startDate}
          />
          {error && (
            <Text fontSize="2xl" colorScheme="red">
              {error.message}
            </Text>
          )}
          <Button type="submit" alignSelf="flex-end" isLoading={loading}>
            Create
          </Button>
        </VStack>
      </form>
    </Container>
  );
};

export default NewSchedule;
