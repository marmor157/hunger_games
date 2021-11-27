import { Control, Controller, FieldValues, Path } from "react-hook-form";
import {
  FormControl,
  FormErrorMessage,
  FormLabel,
} from "@chakra-ui/form-control";
import React, { ReactElement } from "react";
import { Select, SelectProps } from "@chakra-ui/react";

interface FormControlSelectProps<
  T extends FieldValues,
  K extends { id: string; name: string }
> extends SelectProps {
  control: Control<T>;
  name: Path<T>;
  label?: string;
  options: K[];
}

const FormControlSelect = <
  T extends FieldValues,
  K extends { id: string; name: string }
>({
  control,
  name,
  label,
  options,
  ...props
}: FormControlSelectProps<T, K>): ReactElement => {
  return (
    <Controller
      control={control}
      name={name}
      render={({ field, fieldState: { invalid, error } }) => (
        <FormControl isInvalid={invalid}>
          {label && <FormLabel>{label}</FormLabel>}
          <Select {...props} {...field} value={field.value ?? ""}>
            <option disabled></option>
            {options.map((option) => (
              <option key={option.id} value={option.id}>
                {option.name}
              </option>
            ))}
          </Select>
          <FormErrorMessage>{error?.message}</FormErrorMessage>
        </FormControl>
      )}
    ></Controller>
  );
};

export default FormControlSelect;
