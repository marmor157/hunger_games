const DTEND_KEY = "DTEND:";

export default function extractDtendFromRRule(rrule: string): {
  rrule: string;
  dtend?: string;
} {
  const startPos = rrule.indexOf(DTEND_KEY);
  if (startPos != -1) {
    const endLinePos = rrule.indexOf("\n", startPos);
    const dtend = rrule.slice(startPos + DTEND_KEY.length, endLinePos);
    const returnRrule =
      rrule.substr(0, startPos) + rrule.substr(endLinePos + 1);

    return { rrule: returnRrule, dtend };
  }
  return { rrule };
}
