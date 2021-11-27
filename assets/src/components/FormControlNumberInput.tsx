import { Control, Controller, FieldValues, Path } from "react-hook-form";
import {
  FormControl,
  FormErrorMessage,
  FormLabel,
} from "@chakra-ui/form-control";
import {
  NumberInput,
  NumberInputField,
  NumberInputProps,
} from "@chakra-ui/react";
import React, { ReactElement } from "react";

interface FormControlNumberInputProps<T extends FieldValues>
  extends NumberInputProps {
  control: Control<T>;
  name: Path<T>;
  label?: string;
}

const FormControlNumberInput = <T extends FieldValues>({
  control,
  name,
  label,
  ...props
}: FormControlNumberInputProps<T>): ReactElement => {
  return (
    <Controller
      control={control}
      name={name}
      render={({ field, fieldState: { invalid, error } }) => (
        <FormControl isInvalid={invalid}>
          {label && <FormLabel>{label}</FormLabel>}
          <NumberInput {...props} {...field} value={field.value ?? ""}>
            <NumberInputField />
          </NumberInput>
          <FormErrorMessage>{error?.message}</FormErrorMessage>
        </FormControl>
      )}
    ></Controller>
  );
};

export default FormControlNumberInput;
