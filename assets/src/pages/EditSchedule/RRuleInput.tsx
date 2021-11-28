import { HStack, Text, VStack } from "@chakra-ui/layout";
import RRule, { Frequency, Weekday } from "rrule";
import React, { useEffect } from "react";

import { ALL_WEEKDAYS } from "rrule/dist/esm/src/weekday";
import FormControlInput from "../../components/FormControlInput";
import FormControlNumberInput from "../../components/FormControlNumberInput";
import FormControlSelect from "../../components/FormControlSelect";
import { addHours } from "date-fns";
import dateToInputDate from "../../utils/dateToInputDate";
import extractDtendFromRRule from "../../utils/extractDtendFromRRule";
import removeSpecialCharacters from "../../utils/removeSpecialCharacters";
import { useForm } from "react-hook-form";

interface RRuleInputProps {
  rrule?: string;
  onChange: (rrule: string) => void;
}

interface SupportedRRuleOptions {
  dtstart: string;
  interval: number;
  freq: Frequency;
  dtend: string;
  byweekday: number;
}

const weekDays = [
  "Poniedziałek",
  "Wtorek",
  "Środa",
  "Czwartek",
  "Piątek",
  "Sobota",
  "Niedziela",
].map((name, index) => ({
  name,
  id: Weekday.fromStr(ALL_WEEKDAYS[index]).weekday,
}));

const defaultRrule: SupportedRRuleOptions = {
  dtstart: dateToInputDate(new Date()),
  interval: 1,
  freq: Frequency.WEEKLY,
  dtend: dateToInputDate(addHours(new Date(), 1.5)),
  byweekday: RRule.MO.weekday,
};

const composeRRuleString = ({
  dtstart,
  dtend,
  ...options
}: SupportedRRuleOptions) => {
  const rrule = new RRule(options);

  return `DTSTART:${removeSpecialCharacters(
    dtstart
  )}Z\nDTEND:${removeSpecialCharacters(dtend)}Z\n${rrule.toString()}`;
};

const RRuleInput: React.FC<RRuleInputProps> = ({ rrule, onChange }) => {
  const { control, watch, reset } = useForm<SupportedRRuleOptions>({
    defaultValues: defaultRrule,
  });
  const values = watch();

  useEffect(() => {
    const { dtstart, dtend } = values;
    onChange(
      composeRRuleString({
        ...values,
        dtstart: dtstart + ":00",
        dtend: dtend + ":00",
      })
    );
  }, [onChange, values]);

  useEffect(() => {
    if (rrule) {
      const { rrule: sanitizedRRule, dtend } = extractDtendFromRRule(rrule);
      const { options } = RRule.fromString(sanitizedRRule);
      reset({
        ...options,
        byweekday: options.byweekday[0],
        dtend,
        dtstart: dateToInputDate(options.dtstart),
      });
    }
  }, [reset, rrule]);

  return (
    <VStack align="stretch">
      <FormControlInput
        control={control}
        name="dtstart"
        label="Data pierwszych zajęć:"
        type="datetime-local"
      />
      <FormControlInput
        control={control}
        name="dtend"
        label="Data końca pierwszych zajęć:"
        type="datetime-local"
      />
      <HStack>
        <Text>Co</Text>
        <FormControlNumberInput control={control} min={1} name={`interval`} />
        <FormControlSelect
          control={control}
          name="freq"
          options={Object.entries(Frequency).map(([key, value]) => ({
            id: value,
            name: key,
          }))}
        />
        <Text>W</Text>
        <FormControlSelect
          control={control}
          name="byweekday"
          options={weekDays}
        />
      </HStack>
    </VStack>
  );
};

export default RRuleInput;
