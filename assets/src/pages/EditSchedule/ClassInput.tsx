import * as yup from "yup";

import {
  ClassType,
  CreateClassInput,
  useListLecturersQuery,
} from "../../graphql";

import { Button } from "@chakra-ui/react";
import FormControlInput from "../../components/FormControlInput";
import FormControlNumberInput from "../../components/FormControlNumberInput";
import FormControlSelect from "../../components/FormControlSelect";
import RRuleInput from "./RRuleInput";
import React from "react";
import { VStack } from "@chakra-ui/layout";
import { useForm } from "react-hook-form";
import { yupResolver } from "@hookform/resolvers/yup";

export interface ClassInputProps {
  classDefault: Partial<CreateClassInput> &
    Pick<CreateClassInput, "scheduleId">;
  onSave: (data: CreateClassInput) => void;
}

const schema = yup.object({
  name: yup.string().required(),
  rrule: yup.string().required(),
  lecturerId: yup.string().uuid().required(),
  scheduleId: yup.string().required(),
  sizeLimit: yup.number().min(1).required(),
  type: yup.string().oneOf(Object.values(ClassType)).required(),
});

const ClassInput: React.FC<ClassInputProps> = ({ classDefault, onSave }) => {
  const { control, handleSubmit, setValue } = useForm<CreateClassInput>({
    defaultValues: classDefault,
    resolver: yupResolver(schema),
  });

  const { data } = useListLecturersQuery();

  return (
    <form onSubmit={handleSubmit(onSave)}>
      <VStack align="stretch" spacing={4}>
        <FormControlInput
          control={control}
          name={`name`}
          label="Name"
          placeholder="Name"
        />
        <FormControlNumberInput
          control={control}
          name={`sizeLimit`}
          label="Size Limit"
        />
        <FormControlSelect
          control={control}
          name={`lecturerId`}
          label="Lecturer"
          options={data?.listLecturers ?? []}
        />
        <FormControlSelect
          control={control}
          name="type"
          label="Type"
          options={Object.values(ClassType).map((a) => ({ id: a, name: a }))}
        />

        <RRuleInput
          onChange={(rrule) => {
            setValue("rrule", rrule);
          }}
        />
        <Button alignSelf="flex-end" type="submit">
          Add class
        </Button>
      </VStack>
    </form>
  );
};

export default ClassInput;
