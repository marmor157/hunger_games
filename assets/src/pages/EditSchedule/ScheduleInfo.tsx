import { Link } from "react-router-dom";
import React from "react";
import { Schedule } from "../../graphql";
import { Text } from "@chakra-ui/react";
import paths from "../../Routes/paths";

type ScheduleInfoProps = Pick<
  Schedule,
  | "id"
  | "name"
  | "registrationEndDate"
  | "registrationStartDate"
  | "startDate"
  | "endDate"
>;

const ScheduleInfo: React.FC<ScheduleInfoProps> = ({
  id,
  name,
  registrationEndDate,
  registrationStartDate,
  startDate,
  endDate,
}) => {
  return (
    <>
      <Text fontSize="2xl">Edytuj plan: {name}</Text>
      <Link to={paths.schedule.request(id)}>
        Link do zapisów: {window.location.origin + paths.schedule.request(id)}{" "}
      </Link>
      <Text>Data rozpoczęcia: {new Date(startDate).toLocaleDateString()}</Text>
      <Text>Data zakończenia: {new Date(endDate).toLocaleDateString()}</Text>
      <Text>
        Data rozpoczęcia zapisów:{" "}
        {new Date(registrationStartDate).toLocaleString()}
      </Text>
      <Text>
        Data zakończenia zaspisów:{" "}
        {new Date(registrationEndDate).toLocaleString()}
      </Text>
    </>
  );
};

export default ScheduleInfo;
