const Book = document.getElementById('book-table')
image = ["images/design-for-writers-book-cover-tf-2-a-million-to-one.jpg","images/design-for-writers-book-cover-tf-2-a-million-to-one.jpg"]
book_name = []
book_author = []
book_desc = []

let count = 1 
for (let  j = 0; j < 6; j++){
    let HTMLString = `
    <tr class="each_book-row-container">
                <td>
                    <div class="book_content-container">                                
                        <div class="book_img-container" style="display: flex; justify-content: center; align-items: center; margin-left: 10px;">
                            <img id="book_img" src=${image[j]} alt="">
                        </div>
                        <div class="book_detail_main-container">
                            <div class="book_title_container">
                                <h1 id="book_title">A Song of Ice and Fire</h1>
                            </div>
                            <div class="book_author_container">
                                <h4 id="book_author">Goerge R.R. Martin</h4>
                            </div>
                            <hr style="margin-right: 20px;">
                            <div class="book_description_container" style="text-align: justify; margin-right: 20px; margin-top: 5px;">
                                <p id="book_description">Lorem ipsum dolor sit amet consectetur adipisicing elit. Veniam tenetur nulla illum! Laborum exercitationem voluptatibus impedit temporibus pariatur dolor optio velit sint ipsam, eius delectus earum consequuntur commodi repellendus deserunt.</p></div>
                            <div class="book_borrow_button-container" style="display: flex; justify-content: flex-end; margin-right: 20px ;">
                                <button id="borrow_now-btn">Borrow Now</button>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
            `

    Book.innerHTML += HTMLString

    if(count === 6){
        /*CREATING DIV FOR BUTTON*/
        const button_div = document.createElement("div");
        button_div.id = "next_pg-btn-container";

        /*CREATING NEXT PAGE BUTTON*/
        const next_pg_btn = document.createElement("button")
        next_pg_btn.id = "next_page_button"
        next_pg_btn.innerText = "Next Page"

        /*APPENDING DIV AND BUTTON TO THE MAIN TABLE*/
        Book.appendChild(button_div);
        button_div.appendChild(next_pg_btn)
    }
    
    count += 1

}
