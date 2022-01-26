import * as yup from "yup";

import { Button, HStack } from "@chakra-ui/react";
import {
  ClassType,
  CreateClassInput,
  useListLecturersQuery,
} from "../../graphql";
import { useLocation, useNavigate } from "react-router";

import FormControlInput from "../../components/FormControlInput";
import FormControlNumberInput from "../../components/FormControlNumberInput";
import FormControlSelect from "../../components/FormControlSelect";
import RRuleInput from "./RRuleInput";
import React from "react";
import { VStack } from "@chakra-ui/layout";
import classTypeToString from "../../utils/classTypeToString";
import paths from "../../Routes/paths";
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
  const location = useLocation();
  const navigate = useNavigate();
  const { control, handleSubmit, setValue, watch } = useForm<CreateClassInput>({
    defaultValues: {
      ...classDefault,
      ...location.state,
      pathname: undefined,
    },
    resolver: yupResolver(schema),
  });
  const { data } = useListLecturersQuery();

  return (
    <form onSubmit={handleSubmit(onSave)}>
      <VStack align="stretch" spacing={4}>
        <FormControlInput
          control={control}
          name={`name`}
          label="Nazwa"
          placeholder="Nazwa"
        />
        <FormControlNumberInput
          control={control}
          name={`sizeLimit`}
          label="Limit miejsc"
        />
        <HStack alignItems="flex-end">
          <FormControlSelect
            control={control}
            name={`lecturerId`}
            label="Wykładowca"
            options={data?.listLecturers ?? []}
          />
          <Button
            onClick={() => {
              navigate(paths.lecturer.new, {
                state: { ...watch(), pathname: location.pathname },
              });
            }}
          >
            Dodaj
          </Button>
        </HStack>
        <FormControlSelect
          control={control}
          name="type"
          label="Typ"
          options={Object.values(ClassType).map((a) => ({
            id: a,
            name: classTypeToString[a],
          }))}
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
