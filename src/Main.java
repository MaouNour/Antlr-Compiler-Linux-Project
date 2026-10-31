import org.antlr.v4.runtime.*;
import java.io.IOException;

public class Main {
    public static void main(String[] args) throws IOException {

        // Relative to the project root
        String filePath = "input/test";

        CharStream input = CharStreams.fromFileName(filePath);
        MyLexer lexer = new MyLexer(input);

        Token token;
        while ((token = lexer.nextToken()).getType() != Token.EOF) {
            System.out.println(
                "Token: " + lexer.getVocabulary().getSymbolicName(token.getType()) +
                ", Text: " + token.getText()
            );
        }
    }
}