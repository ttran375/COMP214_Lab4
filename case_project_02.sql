-- Case 3-2: Working with More Movie Rentals
-- The More Movie Rental Company is developing an application page that displays the total
-- number of times a specified movie has been rented and the associated rental rating based on
-- this count. Table 3-4 shows the rental ratings.
-- Create a block that retrieves the movie title and rental count based on a movie ID provided
-- via an initialized variable. The block should display the movie title, rental count, and rental rating
-- onscreen. Add exception handlers for errors you can and can’t anticipate. Run the block with
-- movie IDs of 4 and 25.
-- TABLE 3-4 Movie Rental Ratings
-- Number of Rentals Rental Rating
-- Up to 5 Dump
-- 5–20 Low
-- 21–35 Mid
-- More than 35 High
DECLARE
  v_movie_id         NUMBER := 4;
  v_movie_title      VARCHAR2(100);
  v_rental_count     NUMBER;
  v_rental_rating    VARCHAR2(20);
  CURSOR rental_cursor IS
  SELECT
    movie_title,
    COUNT(*)    AS rental_count
  FROM
    rental_history
  WHERE
    movie_id = v_movie_id
  GROUP BY
    movie_title;
  v_custom_exception EXCEPTION;
  PRAGMA EXCEPTION_INIT(v_custom_exception, -20001);
BEGIN
  OPEN rental_cursor;
  FETCH rental_cursor INTO v_movie_title, v_rental_count;
  CLOSE rental_cursor;
  IF v_rental_count >= 10 THEN
    v_rental_rating := 'High';
  ELSIF v_rental_count >= 5 THEN
    v_rental_rating := 'Moderate';
  ELSE
    v_rental_rating := 'Low';
  END IF;

  DBMS_OUTPUT.PUT_LINE('Movie Title: '
                       || v_movie_title);
  DBMS_OUTPUT.PUT_LINE('Rental Count: '
                       || v_rental_count);
  DBMS_OUTPUT.PUT_LINE('Rental Rating: '
                       || v_rental_rating);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No rental history found for the specified movie ID.');
  WHEN v_custom_exception THEN
    DBMS_OUTPUT.PUT_LINE('An unanticipated error occurred: '
                         || SQLERRM);
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: '
                         || SQLERRM);
END;
