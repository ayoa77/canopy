class ApplicationMailer < ActionMailer::Base
  default from: 'boxchoctw@gmail.com'

  def comment_email(name, email, message)
    @name = name
    @email = email
    @message = message
    @time = Time.now
   mail(to: 'ayodeleamadi@gmail.com', subject: "Comment or question from #{@name}, #{@email}") do |format|
     format.html { render layout: 'comment_email' }
   end
 end

  def reserve_email(name, email, message, room, start, finish,nationality, phone)
    @name = name
    @email = email
    @phone = phone
    @nationality = nationality
    @room = room
    @message = message
    @start = start
    @finish = finish
    @time = Time.now
   mail(to: 'ayodeleamadi@gmail.com', subject: "Reservation from #{@name}, #{@email}") do |format|
     format.html { render layout: 'reserve_email' }
   end
end
end
