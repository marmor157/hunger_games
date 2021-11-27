import React from "react";
import { Schedule } from "../../graphql";
import { Text } from "@chakra-ui/react";

type ScheduleInfoProps = Pick<
  Schedule,
  | "name"
  | "registrationEndDate"
  | "registrationStartDate"
  | "startDate"
  | "endDate"
>;

const ScheduleInfo: React.FC<ScheduleInfoProps> = ({
  name,
  registrationEndDate,
  registrationStartDate,
  startDate,
  endDate,
}) => {
  return (
    <>
      <Text fontSize="2xl">Edit schedule: {name}</Text>
      <Text>Start date: {new Date(startDate).toLocaleDateString()}</Text>
      <Text>End date: {new Date(endDate).toLocaleDateString()}</Text>
      <Text>
        Registration start date:{" "}
        {new Date(registrationStartDate).toLocaleString()}
      </Text>
      <Text>
        Registration end date: {new Date(registrationEndDate).toLocaleString()}
      </Text>
    </>
  );
};

export default ScheduleInfo;
