var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
}

//use swagger all environments
app.UseSwagger();
app.UseSwaggerUI();

app.UseRouting();

app.UseAuthorization();

//app.MapControllers(); // trying to not use this

app.UseEndpoints(endpoints =>
{
    endpoints.MapDefaultControllerRoute();

    endpoints.MapGet("/", context =>
    {
        return Task.Run(() => context.Response.Redirect("/swagger"));
    });
});

app.Run();
