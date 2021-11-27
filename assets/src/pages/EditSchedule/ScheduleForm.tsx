import { Box, VStack } from "@chakra-ui/react";
import { CreateClassInput, Schedule } from "../../graphql";

import ClassInput from "./ClassInput";
import React from "react";
import ScheduleInfo from "./ScheduleInfo";

interface ScheduleFormProps
  extends Pick<
    Schedule,
    | "id"
    | "name"
    | "registrationEndDate"
    | "registrationStartDate"
    | "startDate"
    | "endDate"
  > {
  onCreateClass: (data: CreateClassInput) => void;
}

const ScheduleForm: React.FC<ScheduleFormProps> = ({
  id,
  onCreateClass,
  ...props
}) => {
  const isEditable = new Date(props.registrationStartDate) < new Date();

  return (
    <Box w="100%">
      <VStack align="stretch" spacing={4}>
        <ScheduleInfo {...props} />
        {isEditable && (
          <ClassInput
            classDefault={{ scheduleId: id }}
            onSave={onCreateClass}
          />
        )}
      </VStack>
    </Box>
  );
};

export default ScheduleForm;
