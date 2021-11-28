import "./Calendar.scss";

import { Class, Lecturer } from "../../graphql";
import FullCalendar, {
  EventInput,
  EventSourceInput,
} from "@fullcalendar/react";

import { Box } from "@chakra-ui/layout";
import RRule from "rrule";
import React from "react";
import dayGridPlugin from "@fullcalendar/daygrid";
import extractDtendFromRRule from "../../utils/extractDtendFromRRule";
import pl from "@fullcalendar/core/locales/pl";
import timeGridPlugin from "@fullcalendar/timegrid";

interface InternalClass extends Pick<Class, "name" | "rrule"> {
  lecturer: Pick<Lecturer, "name">;
}

interface CalendarProps {
  classes: InternalClass[];
  startDate: Date;
  endDate: Date;
}

const Calendar: React.FC<CalendarProps> = ({ classes, startDate, endDate }) => {
  console.log(classes);
  const events: EventSourceInput = classes.flatMap(
    ({ rrule, name, lecturer }) => {
      const { rrule: sanitizedRRule, dtend } = extractDtendFromRRule(rrule);
      const occurrences = RRule.fromString(sanitizedRRule).between(
        startDate,
        endDate
      );

      const shortName = name
        .split(" ")
        .map((word) => word[0])
        .join("");

      return occurrences.map(
        (occurrence): EventInput => ({
          title: `${shortName} - ${lecturer.name}`,
          start: occurrence,
          end: dtend,
        })
      );
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
        slotMaxTime="22:00"
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
