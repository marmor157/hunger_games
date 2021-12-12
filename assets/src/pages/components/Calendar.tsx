import "./Calendar.scss";

import { Class, ClassType, Lecturer } from "../../graphql";
import FullCalendar, {
  EventInput,
  EventSourceInput,
} from "@fullcalendar/react";
import { addMilliseconds, parseISO } from "date-fns";

import { Box } from "@chakra-ui/layout";
import RRule from "rrule";
import React from "react";
import dayGridPlugin from "@fullcalendar/daygrid";
import extractDtendFromRRule from "../../utils/extractDtendFromRRule";
import pl from "@fullcalendar/core/locales/pl";
import timeGridPlugin from "@fullcalendar/timegrid";

interface InternalClass extends Pick<Class, "id" | "name" | "rrule" | "type"> {
  lecturer: Pick<Lecturer, "name">;
}

interface CalendarProps {
  classes: InternalClass[];
  startDate: Date;
  endDate: Date;
}

const classTypeToShortcut: Record<ClassType, string> = {
  [ClassType.ComputerLaboratories]: "LK",
  [ClassType.Exercises]: "Ć",
  [ClassType.Laboratories]: "L",
  [ClassType.Lecture]: "W",
  [ClassType.Project]: "P",
};

const Calendar: React.FC<CalendarProps> = ({ classes, startDate, endDate }) => {
  const events: EventSourceInput = classes.flatMap(
    ({ rrule, name, lecturer, type, id }) => {
      const { rrule: sanitizedRRule, dtend = "" } =
        extractDtendFromRRule(rrule);
      const parsedRRule = RRule.fromString(sanitizedRRule);
      const dtstart = parsedRRule.origOptions.dtstart ?? new Date();
      const duration = parseISO(dtend).getTime() - dtstart.getTime();
      const occurrences = parsedRRule.between(startDate, endDate);

      const shortName = name
        .split(" ")
        .map((word) => word[0])
        .join("");

      return occurrences.map((occurrence): EventInput => {
        return {
          id: `${id}${occurrence.toString()}`,
          title: `${shortName} - ${lecturer.name} ${classTypeToShortcut[type]}`,
          start: occurrence,
          end: addMilliseconds(occurrence, duration),
        };
      });
    }
  );

  return (
    <Box w="100%">
      <FullCalendar
        locale="pl"
        locales={[pl]}
        plugins={[timeGridPlugin, dayGridPlugin]}
        initialView="timeGridWeek"
        events={events}
        height="auto"
        validRange={{
          start: startDate,
          end: endDate,
        }}
        forceEventDuration={true}
        slotMinTime="07:00:00"
        slotMaxTime="24:00"
        slotEventOverlap={false}
        headerToolbar={{
          right: "dayGridMonth,timeGridWeek today prev,next",
        }}
        allDaySlot={false}
        weekends={false}
        showNonCurrentDates={false}
      />
    </Box>
  );
};

export default Calendar;
