import { Control, Controller, FieldValues, Path } from "react-hook-form";
import {
  FormControl,
  FormErrorMessage,
  FormLabel,
} from "@chakra-ui/form-control";
import { Input, InputProps } from "@chakra-ui/react";
import React, { ReactElement } from "react";

interface FormControlInputProps<T extends FieldValues> extends InputProps {
  control: Control<T>;
  name: Path<T>;
  label?: string;
}

const FormControlInput = <T extends FieldValues>({
  control,
  name,
  label,
  ...props
}: FormControlInputProps<T>): ReactElement => {
  return (
    <Controller
      control={control}
      name={name}
      render={({ field, fieldState: { invalid, error } }) => (
        <FormControl isInvalid={invalid}>
          {label && <FormLabel>{label}</FormLabel>}
          <Input {...props} {...field} value={field.value ?? ""} />
          <FormErrorMessage>{error?.message}</FormErrorMessage>
        </FormControl>
      )}
    ></Controller>
  );
};

export default FormControlInput;
