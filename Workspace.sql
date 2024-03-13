CREATE OR REPLACE FUNCTION get_movie_stock(
  movie_id_in NUMBER
) RETURN VARCHAR2 IS
  v_movie_title mm_movie.movie_title%TYPE;
  v_movie_qty   mm_movie.movie_qty%TYPE;
  v_message     VARCHAR2(100);
BEGIN
 -- Retrieve movie title and quantity based on movie ID
  SELECT
    movie_title,
    movie_qty INTO v_movie_title,
    v_movie_qty
  FROM
    mm_movie
  WHERE
    movie_id = movie_id_in;
 -- Construct message
  v_message := v_movie_title
               || ' is ';
  IF v_movie_qty > 0 THEN
    v_message := v_message
                 || 'Available: '
                 || v_movie_qty
                 || ' on the shelf.';
  ELSE
    v_message := v_message
                 || 'Not available for rental at the moment.';
  END IF;
 -- Return the formatted message
  RETURN v_message;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 'Movie with ID '
           || movie_id_in
           || ' not found.';
END;
/

-- Example usage:
DECLARE
  v_result VARCHAR2(100);
BEGIN
  v_result := get_movie_stock(3); -- Check stock for "Star Wars"
  DBMS_OUTPUT.PUT_LINE(v_result);
END;
