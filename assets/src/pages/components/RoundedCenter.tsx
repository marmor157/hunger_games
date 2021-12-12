import { Box, Center, Flex } from "@chakra-ui/layout";

import React from "react";

const RoundedCenter: React.FC = ({ children }) => {
  return (
    <Flex height="100vh" justify="center">
      <Center>
        <Box bg="gray.700" p={4} borderRadius="lg">
          {children}
        </Box>
      </Center>
    </Flex>
  );
};

export default RoundedCenter;
