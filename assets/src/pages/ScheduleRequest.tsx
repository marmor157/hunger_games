import { Box, Center, Container, Link, Text, VStack } from "@chakra-ui/layout";
import { FieldValues, SubmitHandler, useForm } from "react-hook-form";
import React, { useEffect, useMemo } from "react";
import { Table, Tbody, Td, Thead, Tr } from "@chakra-ui/table";
import { useCreateRequestMutation, useGetScheduleQuery } from "../graphql";

import { Button } from "@chakra-ui/button";
import ControlledRadioGroup from "../components/ControlledRadioGroup";
import FormControlInput from "../components/FormControlInput";
import { NavLink } from "react-router-dom";
import RRule from "rrule";
import { Radio } from "@chakra-ui/radio";
import { Spinner } from "@chakra-ui/spinner";
import extractDtendFromRRule from "../utils/extractDtendFromRRule";
import groupBy from "../utils/groupBy";
import paths from "../Routes/paths";
import { useParams } from "react-router";

const ScheduleRequest: React.FC = () => {
  const { id } = useParams();
  const { data } = useGetScheduleQuery({
    variables: { id: id ?? "" },
  });
  const [createRequest, { data: requestData }] = useCreateRequestMutation();
  const { control, handleSubmit, setValue, watch } = useForm();
  console.log(watch());
  const classes = useMemo(() => {
    return groupBy(
      data?.schedule?.classes ?? [],
      ({ name, type }) => name + type
    );
  }, [data?.schedule?.classes]);

  const onSubmit: SubmitHandler<FieldValues> = ({ studentId, ...data }) => {
    if (!id) return;
    createRequest({
      variables: {
        input: {
          studentId,
          scheduleId: id,
          classes: Object.entries(data).map(([key, value]) => ({
            classId: key,
            priority: parseInt(value),
          })),
        },
      },
    });
  };

  const { visibleSubjects, invisibleSubjects } = useMemo(() => {
    const { true: visibleSubjects, false: invisibleSubjects } = groupBy(
      Object.values(classes),
      (cls) => String(cls.length > 1)
    );
    return { visibleSubjects, invisibleSubjects };
  }, [classes]);

  useEffect(() => {
    if (invisibleSubjects)
      invisibleSubjects
        .map((subject) => subject[0])
        .map((cls) => cls.id)
        .map((id) => setValue(id, 1));
  }, [invisibleSubjects, setValue]);

  if (requestData?.requestCreate) {
    const { student, schedule, date } = requestData.requestCreate;
    const link = paths.assignedSchedule.details(schedule.id, student.id);
    return (
      <Container>
        <VStack>
          <Text>
            Zgłoszenie zostało przyjęte o {new Date(date).toLocaleString()},
            plan będzie dostępny pod tym adresem:
          </Text>
          <Link as={NavLink} to={link}>
            {link}
          </Link>
        </VStack>
      </Container>
    );
  }

  if (!data?.schedule || !id)
    return (
      <Center>
        <Spinner />
      </Center>
    );

  if (new Date(data.schedule.registrationStartDate) > new Date())
    return (
      <Center>
        <Text>
          Rejestracja rozpoczyna się{" "}
          {new Date(data.schedule.registrationStartDate).toLocaleString()}
        </Text>
      </Center>
    );

  if (new Date(data.schedule.registrationEndDate) < new Date())
    return (
      <Center>
        <Text>Rejestracja zakończyła się</Text>
      </Center>
    );

  return (
    <Container>
      <form onSubmit={handleSubmit(onSubmit)}>
        <VStack spacing={2}>
          <FormControlInput
            control={control}
            name="studentId"
            label="Student Id"
          />
          {Object.values(visibleSubjects).map((classArray, index) => (
            <Box
              key={index}
              p={2}
              borderWidth={1}
              margin={2}
              width="100%"
              borderRadius={10}
            >
              <Table variant="striped">
                <Thead>
                  <Tr>
                    <Td>
                      <Text>
                        {classArray[0].name} - {classArray[0].type}
                      </Text>
                    </Td>
                    {classArray.map((_, index) => (
                      <Td key={index}>{index + 1}</Td>
                    ))}
                  </Tr>
                </Thead>
                <Tbody>
                  {classArray.map((cls, _, arr) => {
                    const { rrule: rruleStr } = extractDtendFromRRule(
                      cls.rrule
                    );
                    const rrule = RRule.fromString(rruleStr);

                    const occurrence = rrule.all((_, index) => index < 1)[0];
                    const { interval, byweekday, freq } = rrule.options;
                    return (
                      <ControlledRadioGroup
                        as={Tr}
                        key={cls.id}
                        control={control}
                        name={cls.id}
                      >
                        <Td>
                          {new Date(occurrence).toLocaleString(
                            navigator.language
                          )}
                          - {new RRule({ interval, byweekday, freq }).toText()}
                        </Td>

                        {arr.map((_, index) => (
                          <Td key={index}>
                            <Radio value={index + ""} />
                          </Td>
                        ))}
                      </ControlledRadioGroup>
                    );
                  })}
                </Tbody>
              </Table>
            </Box>
          ))}
          <Button type="submit">Submit</Button>
        </VStack>
      </form>
    </Container>
  );
};

export default ScheduleRequest;
