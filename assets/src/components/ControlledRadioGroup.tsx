import { Control, Controller, FieldValues, Path } from "react-hook-form";
import { RadioGroup, RadioGroupProps } from "@chakra-ui/radio";

import React from "react";

interface ControlledRadioGroupProps<T extends FieldValues = FieldValues>
  extends RadioGroupProps {
  control: Control<T>;
  name: Path<T>;
}

const ControlledRadioGroup: React.FC<ControlledRadioGroupProps> = ({
  control,
  name,
  children,
  ...props
}) => {
  return (
    <Controller
      control={control}
      name={name}
      render={({ field }) => (
        <RadioGroup {...field} {...props}>
          {children}
        </RadioGroup>
      )}
    ></Controller>
  );
};

export default ControlledRadioGroup;
