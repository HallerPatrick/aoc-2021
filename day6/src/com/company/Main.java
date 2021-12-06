package com.company;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.stream.Collectors;

public class Main {

  public static void main(String[] args) {
    String inputContent = Main.readInInput();

    ArrayList<Integer> content =
        new ArrayList(Arrays.stream(inputContent.split(","))
                          .map(Integer::parseInt)
                          .collect(Collectors.toList()));

    ArrayList<Integer> result = Main.simulate(content);

    System.out.println(result.size());
  }

  private static ArrayList<Integer> simulate(ArrayList<Integer> fishList) {
    for (int i = 0; i < 80; i++) {
      for (int f = 0; f < fishList.size(); f++) {
        if (fishList.get(f) == 0) {
          fishList.set(f, 6);
          fishList.add(9);
        } else {
          fishList.set(f, fishList.get(f) - 1);
        }
      }
    }
    return fishList;
  }

  private static String readInInput() {
    Path path = Paths.get("input2.txt");

    String inputFile;
    try {
      inputFile = Files.readAllLines(path).get(0);
    } catch (IOException e) {
      inputFile = "";
      e.printStackTrace();
    }

    return inputFile;
  }
}
